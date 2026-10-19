import 'dart:convert';
import 'dart:typed_data';

import '../../../l10n/l10n.dart';
import '../domain/gcode_metadata.dart';
import '../domain/slice_file.dart';
import 'byte_source.dart';
import 'zip_slice.dart';

/// Reads a `.gcode` or `.3mf` payload that is already in memory (browser picks).
Future<GcodeImport> importGcodeBytes(
  Uint8List bytes, {
  required String displayName,
}) {
  return importSlice(MemoryBytes(bytes), displayName: displayName);
}

Future<GcodeImport> importSlice(
  ByteSource source, {
  required String displayName,
}) async {
  if (isThreeMfFileName(displayName)) {
    return _importThreeMf(source, displayName: displayName);
  }
  final edges = await readByteEdges(
    source,
    headBytes: gcodeHeadBytes,
    tailBytes: gcodeTailBytes,
  );
  final plate = _combinePlates(
    parseGcodeText(utf8.decode(edges.head, allowMalformed: true)),
    parseGcodeText(utf8.decode(edges.tail, allowMalformed: true)),
    name: sliceFileStem(displayName),
  );
  return GcodeImport(
    title: sliceFileStem(displayName),
    plates: [plate],
    note: gcodePlateNote(plate, l10n: activeGramnotaL10n),
  );
}

GcodePlate _combinePlates(
  GcodePlate head,
  GcodePlate tail, {
  required String name,
}) {
  final filaments = head.filaments.isNotEmpty ? head.filaments : tail.filaments;
  final notes = head.filaments.isNotEmpty ? head.notes : tail.notes;
  return GcodePlate(
    name: name,
    slicer: head.slicer.isNotEmpty ? head.slicer : tail.slicer,
    printTimeSeconds: head.printTimeSeconds ?? tail.printTimeSeconds,
    filaments: filaments,
    notes: notes,
  );
}

Future<GcodeImport> _importThreeMf(
  ByteSource source, {
  required String displayName,
}) async {
  final members = await readZipMembers(source);
  final plates = <String, _PlateDraft>{};
  String? objectName;
  for (final member in members) {
    final lower = member.name.toLowerCase();
    if (lower.endsWith('/') || lower.contains('__macosx')) {
      continue;
    }
    if (lower.endsWith('.gcode') || lower.endsWith('.gco')) {
      final edges = await readMemberEdges(
        source,
        member,
        headBytes: gcodeHeadBytes,
        tailBytes: gcodeTailBytes,
      );
      final plate = _combinePlates(
        parseGcodeText(utf8.decode(edges.head, allowMalformed: true)),
        parseGcodeText(utf8.decode(edges.tail, allowMalformed: true)),
        name: _plateName(member.name),
      );
      _draft(plates, member.name)
        ..gcode = plate
        ..name = _plateName(member.name);
      continue;
    }
    if (lower.endsWith('.json') && lower.contains('plate')) {
      final bytes = await _readSmall(source, member);
      if (bytes == null) {
        continue;
      }
      final decoded = jsonDecode(utf8.decode(bytes, allowMalformed: true));
      if (decoded is Map) {
        _draft(plates, member.name).json = decoded.cast<String, Object?>();
      }
      continue;
    }
    if (objectName == null && lower.endsWith('.model')) {
      final edges = await readMemberEdges(
        source,
        member,
        headBytes: 128 * 1024,
        tailBytes: 0,
      );
      objectName = _objectName(utf8.decode(edges.head, allowMalformed: true));
    }
  }
  final keys = plates.keys.toList()..sort(_comparePlateKeys);
  final built = <GcodePlate>[];
  for (final key in keys) {
    final draft = plates[key]!;
    final plate = _withJson(draft);
    if (plate.hasData || plates.length == 1) {
      built.add(plate);
    }
  }
  final title = built.length == 1 && objectName != null && objectName.isNotEmpty
      ? objectName
      : sliceFileStem(displayName);
  if (built.isEmpty) {
    final empty = GcodePlate(
      name: title,
      slicer: '',
      printTimeSeconds: null,
      filaments: const [],
    );
    return GcodeImport(
      title: title,
      plates: [empty],
      note: gcodePlateNote(empty, l10n: activeGramnotaL10n),
    );
  }
  return GcodeImport(
    title: title,
    plates: built,
    note: gcodePlateNote(
      built.first,
      l10n: activeGramnotaL10n,
      plateCount: built.length,
    ),
  );
}

_PlateDraft _draft(Map<String, _PlateDraft> plates, String memberName) {
  final key = _plateKey(memberName);
  return plates.putIfAbsent(key, () {
    final draft = _PlateDraft()..name = _plateName(memberName);
    return draft;
  });
}

Future<Uint8List?> _readSmall(ByteSource source, ZipMember member) async {
  if (member.uncompressedSize > 2 * 1024 * 1024) {
    return null;
  }
  return readMemberBytes(source, member);
}

GcodePlate _withJson(_PlateDraft draft) {
  final base =
      draft.gcode ??
      GcodePlate(
        name: draft.name,
        slicer: '',
        printTimeSeconds: null,
        filaments: const [],
      );
  final json = draft.json;
  if (json == null) {
    return base;
  }
  var seconds = base.printTimeSeconds;
  if (seconds == null) {
    final prediction = json['prediction'];
    if (prediction is num && prediction > 0) {
      seconds = prediction.round();
    }
  }
  var filaments = base.filaments;
  if (filaments.isEmpty) {
    filaments = _filamentsFromJson(json);
  }
  return GcodePlate(
    name: base.name.isEmpty ? draft.name : base.name,
    slicer: base.slicer,
    printTimeSeconds: seconds,
    filaments: filaments,
    notes: base.notes,
  );
}

List<GcodeFilament> _filamentsFromJson(Map<String, Object?> json) {
  final weight =
      json['weight'] ?? json['filament_weight'] ?? json['filament_weights'];
  final weights = <double>[];
  if (weight is num) {
    weights.add(weight.toDouble());
  } else if (weight is List) {
    for (final item in weight) {
      if (item is num) {
        weights.add(item.toDouble());
      }
    }
  }
  final colors = _stringList(json['filament_colors'] ?? json['filament_color']);
  final types = _stringList(json['filament_types'] ?? json['filament_type']);
  final filaments = <GcodeFilament>[];
  for (var i = 0; i < weights.length; i++) {
    final grams = (weights[i] * 1000).round() / 1000;
    if (grams <= 0) {
      continue;
    }
    filaments.add(
      GcodeFilament(
        grams: grams,
        material: i < types.length ? types[i] : '',
        colorHex: i < colors.length ? colors[i] : '',
      ),
    );
  }
  return filaments;
}

List<String> _stringList(Object? value) {
  if (value is String) {
    return value
        .split(RegExp(r'[;,]'))
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .toList();
  }
  if (value is List) {
    return [
      for (final item in value)
        if (item != null && item.toString().trim().isNotEmpty)
          item.toString().trim(),
    ];
  }
  return const [];
}

String? _objectName(String xml) {
  final match = RegExp(
    r'<object\b[^>]*\bname="([^"]+)"',
    caseSensitive: false,
  ).firstMatch(xml);
  final name = match?.group(1)?.trim();
  if (name == null || name.isEmpty) {
    return null;
  }
  return name;
}

String _plateKey(String name) {
  final match = RegExp(
    r'plate[_\- ]?(\d+)',
    caseSensitive: false,
  ).firstMatch(name);
  if (match != null) {
    return match.group(1)!;
  }
  return name;
}

String _plateName(String name) {
  final match = RegExp(
    r'plate[_\- ]?(\d+)',
    caseSensitive: false,
  ).firstMatch(name);
  if (match != null) {
    return activeGramnotaL10n.gcodePlateName(int.parse(match.group(1)!));
  }
  return sliceFileStem(name);
}

/// User-facing text for a slice-file failure. Known archive errors are
/// translated; anything else keeps the exception text.
String describeGcodeError(Object error, AppLocalizations l10n) {
  final raw = switch (error) {
    FormatException(:final message) => message,
    UnsupportedError(:final message) => message ?? '',
    _ => '',
  };
  if (raw == 'Not a 3MF archive.') {
    return l10n.gcodeNotArchive;
  }
  if (raw == 'This 3MF uses Zip64, which Gramnota cannot read.') {
    return l10n.gcodeZip64;
  }
  if (raw == 'The 3MF archive is incomplete.') {
    return l10n.gcodeArchiveIncomplete;
  }
  if (raw == 'The 3MF archive is missing a file header.') {
    return l10n.gcodeMissingHeader;
  }
  if (raw == 'This browser build reads the file you pick, not a disk path.') {
    return l10n.gcodeBrowserPath;
  }
  final compression = RegExp(
    r'^Unsupported compression in (.+) \(method (\d+)\)\.$',
  ).firstMatch(raw);
  if (compression != null) {
    return l10n.gcodeUnsupportedCompression(
      compression.group(1)!,
      compression.group(2)!,
    );
  }
  if (raw.isNotEmpty) {
    return raw;
  }
  return error.toString();
}

int _comparePlateKeys(String a, String b) {
  final left = int.tryParse(a);
  final right = int.tryParse(b);
  if (left != null && right != null) {
    return left.compareTo(right);
  }
  return a.compareTo(b);
}

class _PlateDraft {
  String name = '';
  GcodePlate? gcode;
  Map<String, Object?>? json;
}
