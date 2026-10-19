import 'dart:convert';

import '../domain/import_models.dart';

class CrealityCloudImporter {
  const CrealityCloudImporter();

  static final _slug = RegExp(r'/model-detail/([^/?#]+)');

  bool canHandle(Uri uri) => uri.host.contains('crealitycloud.com');

  Future<ImportResult> import(Uri uri, TextFetcher fetcher) async {
    final slug = _slug.firstMatch(uri.path)?.group(1);
    if (slug == null) {
      return ImportResult(
        title: '',
        sourceUrl: uri.toString(),
        profiles: const [],
        missing: const ['print time', 'filament weight'],
        note: 'This Creality Cloud link does not point at a model.',
      );
    }
    final html = await fetcher.get(uri);
    final title = _title(html) ?? slug.replaceAll('-', ' ');
    final payload = _payload(html);
    if (payload == null) {
      return ImportResult(
        title: title,
        sourceUrl: uri.toString(),
        profiles: const [],
        missing: const ['print time', 'filament weight'],
        note: 'Creality Cloud did not publish print time or filament weight.',
      );
    }
    final revived = reviveNuxtPayload(jsonDecode(payload));
    final stats = _findStats(revived);
    if (stats == null) {
      return ImportResult(
        title: title,
        sourceUrl: uri.toString(),
        profiles: const [],
        missing: const ['print time', 'filament weight'],
        note: 'Creality Cloud did not publish print time or filament weight.',
      );
    }
    return ImportResult(
      title: title,
      sourceUrl: uri.toString(),
      profiles: [
        ImportedProfile(
          id: slug,
          title: title,
          printTimeSeconds: stats.seconds,
          filaments: stats.filaments,
        ),
      ],
    );
  }

  String? _title(String html) {
    final og = RegExp(
      '''<meta[^>]+property=["']og:title["'][^>]+content=["']([^"']+)["']''',
      caseSensitive: false,
    ).firstMatch(html);
    if (og != null) {
      return cleanModelTitle(_decode(og.group(1)!));
    }
    final swapped = RegExp(
      '''<meta[^>]+content=["']([^"']+)["'][^>]+property=["']og:title["']''',
      caseSensitive: false,
    ).firstMatch(html);
    if (swapped != null) {
      return cleanModelTitle(_decode(swapped.group(1)!));
    }
    final title = RegExp(
      '<title>([^<]+)</title>',
      caseSensitive: false,
    ).firstMatch(html);
    return title == null
        ? null
        : cleanModelTitle(_decode(title.group(1)!));
  }

  String? _payload(String html) {
    final match = RegExp(
      r'id="__NUXT_DATA__"[^>]*>(.*?)</script>',
      dotAll: true,
    ).firstMatch(html);
    return match?.group(1);
  }

  _CrealityStats? _findStats(Object? node) {
    if (node is Map) {
      final time = node['printTime'];
      final weight = node['filamentWeight'];
      if (time is num && weight is num) {
        final colors = node['colorFilament'];
        final filaments = <ImportedFilament>[];
        if (colors is List) {
          for (final color in colors) {
            if (color is! Map) {
              continue;
            }
            final grams = color['weight'];
            if (grams is! num) {
              continue;
            }
            filaments.add(
              ImportedFilament(
                grams: grams.toDouble(),
                material: '${color['type'] ?? ''}',
                colorHex: '${color['color'] ?? ''}',
              ),
            );
          }
        }
        return _CrealityStats(
          seconds: time.round(),
          filaments: filaments.isEmpty
              ? [ImportedFilament(grams: weight.toDouble())]
              : filaments,
        );
      }
      for (final value in node.values) {
        final found = _findStats(value);
        if (found != null) {
          return found;
        }
      }
    } else if (node is List) {
      for (final value in node) {
        final found = _findStats(value);
        if (found != null) {
          return found;
        }
      }
    }
    return null;
  }

  String _decode(String value) => value
      .replaceAll('&amp;', '&')
      .replaceAll('&#39;', "'")
      .replaceAll('&quot;', '"');
}

class _CrealityStats {
  const _CrealityStats({required this.seconds, required this.filaments});

  final int seconds;
  final List<ImportedFilament> filaments;
}

/// Revives a Nuxt 3 `__NUXT_DATA__` array, where integers inside objects are
/// indexes into that array.
Object? reviveNuxtPayload(Object? json) {
  if (json is! List) {
    return json;
  }
  final refs = <int, Object?>{};
  final visiting = <int>{};

  Object? revive(int index) {
    if (index < 0 || index >= json.length) {
      return null;
    }
    if (refs.containsKey(index)) {
      return refs[index];
    }
    if (!visiting.add(index)) {
      return null;
    }
    final value = json[index];
    if (value is List) {
      if (value.isNotEmpty && value.first is String) {
        final marker = value.first as String;
        if (_markers.contains(marker)) {
          final inner = value.length > 1 && value[1] is int
              ? revive(value[1] as int)
              : null;
          refs[index] = inner;
          visiting.remove(index);
          return inner;
        }
      }
      final list = <Object?>[];
      refs[index] = list;
      for (final item in value) {
        list.add(item is int ? revive(item) : item);
      }
      visiting.remove(index);
      return list;
    }
    if (value is Map) {
      final map = <String, Object?>{};
      refs[index] = map;
      value.forEach((key, item) {
        map['$key'] = item is int ? revive(item) : item;
      });
      visiting.remove(index);
      return map;
    }
    refs[index] = value;
    visiting.remove(index);
    return value;
  }

  return revive(0);
}

const _markers = {
  'ShallowReactive',
  'Reactive',
  'Ref',
  'EmptyRef',
  'EmptyShallowRef',
  'ShallowRef',
};
