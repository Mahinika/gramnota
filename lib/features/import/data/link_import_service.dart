import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/import_models.dart';
import 'creality_importer.dart';
import 'makerworld_importer.dart';
import 'printables_importer.dart';

class LinkImportService {
  LinkImportService({
    TextFetcher? fetcher,
    MakerWorldImporter? makerWorld,
    PrintablesImporter? printables,
    CrealityCloudImporter? creality,
  }) : _fetcher = fetcher ?? HttpTextFetcher(),
       _makerWorld = makerWorld ?? const MakerWorldImporter(),
       _printables = printables ?? const PrintablesImporter(),
       _creality = creality ?? const CrealityCloudImporter();

  final TextFetcher _fetcher;
  final MakerWorldImporter _makerWorld;
  final PrintablesImporter _printables;
  final CrealityCloudImporter _creality;

  static const titleOnlyHosts = [
    'thingiverse.com',
    'thangs.com',
    'cults3d.com',
    'myminifactory.com',
    'makeronline.com',
    'nexprint.com',
    'grabcad.com',
  ];

  Future<ImportResult> importUri(Uri uri, {bool allowHop = true}) async {
    if (_makerWorld.canHandle(uri)) {
      return _makerWorld.import(uri, _fetcher);
    }
    if (_printables.canHandle(uri)) {
      return _printables.import(uri, _fetcher);
    }
    if (_creality.canHandle(uri)) {
      return _creality.import(uri, _fetcher);
    }
    if (titleOnlyHosts.any((host) => uri.host.contains(host))) {
      return _titleOnly(uri, allowHop: allowHop);
    }
    return ImportResult(
      title: '',
      sourceUrl: uri.toString(),
      profiles: const [],
      missing: const ['print time', 'filament weight'],
      note: 'This site is not supported yet. Enter the print by hand.',
    );
  }

  Future<ImportResult> importText(String raw) {
    final uri = Uri.tryParse(raw.trim());
    if (uri == null || !uri.hasScheme) {
      return Future.value(
        ImportResult(
          title: '',
          sourceUrl: raw.trim(),
          profiles: const [],
          missing: const ['print time', 'filament weight'],
          note: 'Paste a full link, starting with https://.',
        ),
      );
    }
    return importUri(uri);
  }

  Future<ImportResult> _titleOnly(Uri uri, {required bool allowHop}) async {
    final html = await _fetcher.get(uri);
    if (allowHop) {
      final hop = _supportedLink(html);
      if (hop != null) {
        return importUri(hop, allowHop: false);
      }
    }
    final title = _ogTitle(html) ?? '';
    return ImportResult(
      title: title,
      sourceUrl: uri.toString(),
      profiles: const [],
      missing: const ['print time', 'filament weight'],
      note:
          'This site did not publish print time or filament weight. The title was filled in when it was available.',
    );
  }

  Uri? _supportedLink(String html) {
    final match = RegExp(
      r'https://(?:www\.)?(?:makerworld\.com|printables\.com|crealitycloud\.com)/[^\s"<>]+',
      caseSensitive: false,
    ).firstMatch(html);
    if (match == null) {
      return null;
    }
    return Uri.tryParse(match.group(0)!);
  }

  String? _ogTitle(String html) {
    final og = RegExp(
      '''<meta[^>]+property=["']og:title["'][^>]+content=["']([^"']+)["']''',
      caseSensitive: false,
    ).firstMatch(html);
    final raw = og?.group(1);
    if (raw == null || raw.trim().isEmpty) {
      return null;
    }
    return raw.trim();
  }
}

class HttpTextFetcher implements TextFetcher {
  HttpTextFetcher({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<String> get(Uri uri) async {
    final response = await _client.get(
      uri,
      headers: const {'User-Agent': 'PrintPrice/1.0'},
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Request failed (${response.statusCode}) for $uri');
    }
    return response.body;
  }

  @override
  Future<String> postJson(Uri uri, Map<String, Object?> body) async {
    final response = await _client.post(
      uri,
      headers: const {
        'User-Agent': 'PrintPrice/1.0',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Request failed (${response.statusCode}) for $uri');
    }
    return response.body;
  }
}

class HttpException implements Exception {
  HttpException(this.message);
  final String message;
  @override
  String toString() => message;
}
