import 'dart:convert';

import '../../../l10n/l10n.dart';
import '../domain/import_models.dart';

class PrintablesImporter {
  const PrintablesImporter();

  static final _model = RegExp(r'/model/(\d+)');

  bool canHandle(Uri uri) => uri.host.contains('printables.com');

  Future<ImportResult> import(Uri uri, TextFetcher fetcher) async {
    final match = _model.firstMatch(uri.path);
    if (match == null) {
      return ImportResult(
        title: '',
        sourceUrl: uri.toString(),
        profiles: const [],
        missing: const ['print time', 'filament weight'],
        note: 'This Printables link does not point at a model.',
      );
    }
    final id = match.group(1)!;
    const query = r'''
query PrintFiles($id: ID!) {
  print(id: $id) {
    id
    name
    printDuration
    weight
    gcodes {
      id
      name
      printDuration
      weight
      material { name }
      printer { name }
    }
  }
}
''';
    final body = await fetcher.postJson(
      Uri.parse('https://api.printables.com/graphql/'),
      {
        'operationName': 'PrintFiles',
        'variables': {'id': id},
        'query': query,
      },
    );
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Printables response was not an object.');
    }
    final data = decoded['data'];
    final print = data is Map ? data['print'] : null;
    if (print is! Map) {
      throw const FormatException('Printables did not return a model.');
    }
    final model = Map<String, dynamic>.from(print);
    final title = '${model['name'] ?? ''}'.trim();
    final modelSeconds = _hoursToSeconds(model['printDuration']);
    final modelGrams = _grams(model['weight']);
    final profiles = <ImportedProfile>[];
    final gcodes = model['gcodes'];
    if (gcodes is List && gcodes.isNotEmpty) {
      for (final raw in gcodes) {
        if (raw is! Map) {
          continue;
        }
        final file = Map<String, dynamic>.from(raw);
        final seconds = _hoursToSeconds(file['printDuration']) ?? modelSeconds;
        final grams = _grams(file['weight']) ?? modelGrams;
        final material = file['material'] is Map
            ? '${(file['material'] as Map)['name'] ?? ''}'
            : '';
        final printer = file['printer'] is Map
            ? '${(file['printer'] as Map)['name'] ?? ''}'
            : '';
        profiles.add(
          ImportedProfile(
            id: '${file['id'] ?? ''}',
            title: '${file['name'] ?? activeGramnotaL10n.importPrintFile}',
            printTimeSeconds: seconds,
            printerName: printer,
            filaments: grams == null
                ? const []
                : [ImportedFilament(grams: grams, material: material)],
          ),
        );
      }
    } else if (modelSeconds != null || modelGrams != null) {
      profiles.add(
        ImportedProfile(
          id: id,
          title: title,
          printTimeSeconds: modelSeconds,
          filaments: modelGrams == null
              ? const []
              : [ImportedFilament(grams: modelGrams)],
        ),
      );
    }
    final missing = <String>[];
    if (profiles.every((profile) => profile.printTimeSeconds == null)) {
      missing.add('print time');
    }
    if (profiles.every((profile) => profile.filaments.isEmpty)) {
      missing.add('filament weight');
    }
    return ImportResult(
      title: title,
      sourceUrl: uri.toString(),
      profiles: profiles,
      missing: missing,
      note: missing.isEmpty
          ? ''
          : 'Printables did not publish ${missing.join(' and ')} for this model.',
    );
  }

  int? _hoursToSeconds(Object? value) {
    final hours = value is num ? value.toDouble() : double.tryParse('$value');
    if (hours == null) {
      return null;
    }
    return (hours * 3600).round();
  }

  double? _grams(Object? value) {
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse('$value');
  }
}
