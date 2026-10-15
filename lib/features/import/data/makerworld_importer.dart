import 'dart:convert';

import '../domain/import_models.dart';

class MakerWorldImporter {
  const MakerWorldImporter();

  static final _model = RegExp(r'/models/(\d+)');
  static final _profile = RegExp(r'profileId-(\d+)');

  bool canHandle(Uri uri) => uri.host.contains('makerworld.com');

  Future<ImportResult> import(Uri uri, TextFetcher fetcher) async {
    final modelMatch = _model.firstMatch(uri.path);
    if (modelMatch == null) {
      return ImportResult(
        title: '',
        sourceUrl: uri.toString(),
        profiles: const [],
        missing: const ['print time', 'filament weight'],
        note: 'This MakerWorld link does not point at a model.',
      );
    }
    final designId = modelMatch.group(1)!;
    final body = await fetcher.get(
      Uri.parse(
        'https://api.bambulab.com/v1/design-service/design/$designId',
      ),
    );
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('MakerWorld response was not an object.');
    }
    final design = decoded['design'] is Map<String, dynamic>
        ? decoded['design'] as Map<String, dynamic>
        : decoded;
    final title = (design['title'] as String?)?.trim() ?? '';
    final wanted = _profile.firstMatch(uri.fragment)?.group(1);
    final instances = (design['instances'] as List?) ?? const [];
    final profiles = <ImportedProfile>[];
    for (final raw in instances) {
      if (raw is! Map) {
        continue;
      }
      final instance = Map<String, dynamic>.from(raw);
      final id = '${instance['id'] ?? ''}';
      final profileId = '${instance['profileId'] ?? ''}';
      if (wanted != null && wanted != id && wanted != profileId) {
        continue;
      }
      profiles.add(_profileFrom(instance));
    }
    final missing = <String>[];
    if (profiles.isEmpty) {
      missing.addAll(['print time', 'filament weight']);
    }
    return ImportResult(
      title: title,
      sourceUrl: uri.toString(),
      profiles: profiles,
      missing: missing,
      note: profiles.isEmpty
          ? 'This model has no published print profile. Time and weight were not published.'
          : '',
    );
  }

  ImportedProfile _profileFrom(Map<String, dynamic> instance) {
    final extension = instance['extention'];
    final extensionMap = extension is Map
        ? Map<String, dynamic>.from(extension)
        : const <String, dynamic>{};
    final modelInfo = extensionMap['modelInfo'];
    final info = modelInfo is Map
        ? Map<String, dynamic>.from(modelInfo)
        : const <String, dynamic>{};
    final compatibility = info['compatibility'];
    final printerName = compatibility is Map
        ? '${compatibility['devProductName'] ?? ''}'
        : '';
    final variants = <PrinterVariant>[];
    final others = extensionMap['otherCompatibilityModelInfo'];
    if (others is List) {
      for (final raw in others) {
        if (raw is! Map) {
          continue;
        }
        final variant = Map<String, dynamic>.from(raw);
        final seconds = _seconds(variant['prediction']);
        if (seconds == null) {
          continue;
        }
        variants.add(
          PrinterVariant(
            printerName: '${variant['devProductName'] ?? ''}',
            printTimeSeconds: seconds,
            filaments: _filaments(variant['instanceFilaments']),
          ),
        );
      }
    }
    return ImportedProfile(
      id: '${instance['profileId'] ?? instance['id'] ?? ''}',
      title: '${instance['title'] ?? ''}',
      printTimeSeconds: _seconds(instance['prediction']),
      printerName: printerName,
      filaments: _filaments(instance['instanceFilaments']),
      variants: variants,
    );
  }

  int? _seconds(Object? value) {
    if (value is num) {
      return value.round();
    }
    return int.tryParse('$value');
  }

  List<ImportedFilament> _filaments(Object? raw) {
    if (raw is! List) {
      return const [];
    }
    final rows = <ImportedFilament>[];
    for (final item in raw) {
      if (item is! Map) {
        continue;
      }
      final grams = double.tryParse('${item['usedG']}') ?? 0;
      rows.add(
        ImportedFilament(
          grams: grams,
          material: '${item['type'] ?? ''}',
          colorHex: '${item['color'] ?? ''}',
        ),
      );
    }
    return rows;
  }
}
