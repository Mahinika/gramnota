import 'package:flutter_test/flutter_test.dart';
import 'package:printprice/features/import/data/link_import_service.dart';
import 'package:printprice/features/import/domain/import_models.dart';

class _FakeFetcher implements TextFetcher {
  _FakeFetcher(this.responses);

  final Map<String, String> responses;

  @override
  Future<String> get(Uri uri) async {
    return responses[uri.toString()] ??
        responses[uri.host + uri.path] ??
        (throw StateError('No fixture for $uri'));
  }

  @override
  Future<String> postJson(Uri uri, Map<String, Object?> body) async {
    return responses['POST ${uri.host}'] ??
        (throw StateError('No fixture for $uri'));
  }
}

void main() {
  test('MakerWorld fills time, grams, and a printer variant', () async {
    final design = Uri.parse(
      'https://api.bambulab.com/v1/design-service/design/412809',
    );
    final service = LinkImportService(
      fetcher: _FakeFetcher({
        design.toString(): '''
{
  "title": "Cable saver",
  "instances": [
    {
      "id": 1,
      "profileId": 99,
      "title": "0.2mm",
      "prediction": 1514,
      "instanceFilaments": [{"type": "PETG", "color": "#000000", "usedG": "2"}],
      "extention": {
        "modelInfo": {"compatibility": {"devProductName": "A1"}},
        "otherCompatibilityModelInfo": [
          {
            "devProductName": "P1S",
            "prediction": 1011,
            "instanceFilaments": [{"type": "PLA", "color": "#FFFFFF", "usedG": "3"}]
          }
        ]
      }
    }
  ]
}
''',
      }),
    );

    final result = await service.importText(
      'https://makerworld.com/en/models/412809-cable#profileId-99',
    );

    expect(result.title, 'Cable saver');
    expect(result.profiles.single.printTimeSeconds, 1514);
    expect(result.profiles.single.filaments.single.grams, 2);
    expect(result.profiles.single.variants.single.printerName, 'P1S');
    expect(result.profiles.single.variants.single.printTimeSeconds, 1011);
  });

  test('Printables turns hours into seconds for each gcode', () async {
    final service = LinkImportService(
      fetcher: _FakeFetcher({
        'POST api.printables.com': '''
{
  "data": {
    "print": {
      "id": "3161",
      "name": "3D BENCHY",
      "printDuration": 2.46,
      "weight": 29,
      "gcodes": [
        {
          "id": "a",
          "name": "benchy.gcode",
          "printDuration": 0.14,
          "weight": 6,
          "material": {"name": "PLA"},
          "printer": {"name": "Prusa MINI"}
        }
      ]
    }
  }
}
''',
      }),
    );

    final result = await service.importText(
      'https://www.printables.com/model/3161-3d-benchy',
    );

    expect(result.title, '3D BENCHY');
    expect(result.profiles.single.printTimeSeconds, 504);
    expect(result.profiles.single.filaments.single.grams, 6);
    expect(result.profiles.single.filaments.single.material, 'PLA');
  });

  test('Creality Cloud reads the Nuxt payload', () async {
    const html = '''
<html><head>
<meta property="og:title" content="Patolino">
<script type="application/json" id="__NUXT_DATA__">[["ShallowReactive",1],{"printTime":2,"filamentWeight":3,"colorFilament":4},26117,164.78,[5],{"type":6,"name":7,"color":8,"weight":9},"PLA","Hyper PLA","#00FF80",165.3]</script>
</head></html>
''';
    final page = Uri.parse('https://www.crealitycloud.com/model-detail/patolino');
    final service = LinkImportService(fetcher: _FakeFetcher({page.toString(): html}));

    final result = await service.importUri(page);

    expect(result.title, 'Patolino');
    expect(result.profiles.single.printTimeSeconds, 26117);
    expect(result.profiles.single.filaments.single.material, 'PLA');
    expect(result.profiles.single.filaments.single.grams, 165.3);
  });

  test('a title-only site follows one hop to MakerWorld', () async {
    final thing = Uri.parse('https://www.thingiverse.com/thing:1');
    final design = Uri.parse(
      'https://api.bambulab.com/v1/design-service/design/5',
    );
    final service = LinkImportService(
      fetcher: _FakeFetcher({
        thing.toString():
            '<meta property="og:title" content="Clip"><a href="https://makerworld.com/en/models/5-clip">source</a>',
        design.toString():
            '{"title":"Clip","instances":[{"id":1,"profileId":2,"title":"fast","prediction":60,"instanceFilaments":[{"type":"PLA","color":"#fff","usedG":"1"}]}]}',
      }),
    );

    final result = await service.importUri(thing);

    expect(result.title, 'Clip');
    expect(result.profiles.single.printTimeSeconds, 60);
  });

  test('an unknown site stays manual', () async {
    final service = LinkImportService(fetcher: _FakeFetcher({}));
    final result = await service.importText('https://example.com/model');
    expect(result.note, contains('not supported'));
    expect(result.profiles, isEmpty);
  });
}
