import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/updates/data/update_client.dart';
import 'package:gramnota/features/updates/data/update_preferences.dart';
import 'package:gramnota/features/updates/domain/update_check.dart';
import 'package:gramnota/features/updates/domain/update_failures.dart';
import 'package:gramnota/features/updates/domain/update_models.dart';
import 'package:gramnota/features/updates/presentation/update_dialogs.dart';
import 'package:gramnota/features/updates/presentation/update_section.dart';
import 'package:gramnota/features/updates/update_config.dart';
import 'package:http/http.dart' as http;

void main() {
  test('parses installed build numbers', () {
    expect(parseInstalledBuild('12'), 12);
    expect(parseInstalledBuild('1.0.0+12'), 12);
    expect(parseInstalledBuild('1.0.0.12'), 12);
    expect(parseInstalledBuild('1.0.0'), 0);
    expect(parseInstalledBuild(''), 0);
  });

  test('parses a manifest and rejects a bad one', () {
    final manifest = parseUpdateManifest(
      jsonEncode({
        'version': '1.0.0',
        'android': {
          'build': 9,
          'commit': 'abc',
          'date': '2026-10-19',
          'notes': 'Android 1.0.0 (build 9).',
          'url':
              'https://github.com/Mahinika/gramnota/releases/download/latest/Gramnota.apk',
          'sha256': 'ab' * 32,
        },
      }),
    );
    expect(manifest.version, '1.0.0');
    expect(manifest.android?.build, 9);
    expect(manifest.windows, isNull);
    expect(() => parseUpdateManifest('not-json'), throwsFormatException);
    expect(
      () => parseUpdateManifest(
        jsonEncode({
          'version': '1.0.0',
          'android': {
            'build': 1,
            'url': 'https://example.test/a',
            'sha256': 'abcd',
          },
        }),
      ),
      throwsFormatException,
    );
  });

  test('offers a newer build unless that build was skipped', () {
    expect(isNewerBuild(installed: 4, available: 5), isTrue);
    expect(isNewerBuild(installed: 5, available: 5), isFalse);
    expect(
      shouldOfferUpdate(
        installedBuild: 4,
        availableBuild: 5,
        skippedBuild: null,
        manual: false,
      ),
      isTrue,
    );
    expect(
      shouldOfferUpdate(
        installedBuild: 4,
        availableBuild: 5,
        skippedBuild: 5,
        manual: false,
      ),
      isFalse,
    );
    expect(
      shouldOfferUpdate(
        installedBuild: 4,
        availableBuild: 5,
        skippedBuild: 5,
        manual: true,
      ),
      isTrue,
    );
    expect(
      shouldOfferUpdate(
        installedBuild: 4,
        availableBuild: 6,
        skippedBuild: 5,
        manual: false,
      ),
      isTrue,
    );
    final now = DateTime.utc(2026, 10, 19, 12);
    expect(shouldAutoCheck(lastCheck: null, now: now), isTrue);
    expect(
      shouldAutoCheck(
        lastCheck: now.subtract(const Duration(hours: 23)),
        now: now,
      ),
      isFalse,
    );
    expect(
      shouldAutoCheck(
        lastCheck: now.subtract(const Duration(hours: 24)),
        now: now,
      ),
      isTrue,
    );
  });

  test('swedish messages name the failure', () {
    expect(
      updateFailureMessage(const UpdateChecksumException()),
      'Filen stämde inte (kontrollsumma). Inget installerades.',
    );
    expect(
      updateFailureMessage(const UpdateDownloadException()),
      'Nedladdningen misslyckades.',
    );
    expect(
      updateFailureMessage(const UpdateNetworkException()),
      'Ingen internetanslutning. Försök igen senare.',
    );
    expect(
      updateFailureMessage(const FormatException('bad')),
      'Kunde inte läsa uppdateringsinformationen.',
    );
    expect(
      updateFailureMessage(StateError('x')),
      'Kunde inte söka efter uppdateringar.',
    );
  });

  test('the manifest URL is the public release asset', () {
    expect(
      updateManifestUrl,
      'https://github.com/Mahinika/gramnota/releases/download/latest/latest.json',
    );
  });

  test('a skipped build stays quiet until the user asks', () async {
    final now = DateTime.utc(2026, 10, 19, 8);
    final preferences = MemoryUpdatePreferences()..storedCheck = now;
    final source = _FakeSource(_manifest(build: 8));
    final coordinator = UpdateCoordinator(
      client: source,
      preferences: preferences,
      platform: UpdatePlatform.android,
      installedBuild: 4,
      now: () => now,
    );
    final skippedDay = await coordinator.check(manual: false);
    expect(skippedDay.artifact, isNull);
    expect(source.fetches, 0);

    preferences.storedCheck = null;
    preferences.storedSkip = 8;
    final hidden = await coordinator.check(manual: false);
    expect(hidden.artifact, isNull);
    expect(source.fetches, 1);
    expect(preferences.storedCheck, now);

    final asked = await coordinator.check(manual: true);
    expect(asked.artifact?.build, 8);
  });

  test('automatic checks swallow network errors', () async {
    final preferences = MemoryUpdatePreferences();
    final source = _FakeSource(
      _manifest(build: 8),
      error: const UpdateNetworkException(),
    );
    final coordinator = UpdateCoordinator(
      client: source,
      preferences: preferences,
      platform: UpdatePlatform.windows,
      installedBuild: 1,
      now: () => DateTime.utc(2026, 10, 19),
    );
    final auto = await coordinator.check(manual: false);
    expect(auto.message, isNull);
    expect(preferences.storedCheck, isNull);

    final manual = await coordinator.check(manual: true);
    expect(manual.message, 'Ingen internetanslutning. Försök igen senare.');

    source.error = null;
    source.manifest = _manifest(build: 1, windowsOnly: true);
    final current = await UpdateCoordinator(
      client: source,
      preferences: MemoryUpdatePreferences(),
      platform: UpdatePlatform.windows,
      installedBuild: 1,
      now: () => DateTime.utc(2026, 10, 19),
    ).check(manual: true);
    expect(current.upToDate, isTrue);
    expect(current.message, 'Du har redan den senaste versionen.');
  });

  test(
    'a local manifest offers the newer file and checks its checksum',
    () async {
      await HttpOverrides.runWithHttpOverrides(
        _downloadFromLocalServer,
        _RealHttpOverrides(),
      );
    },
  );

  test('the windows installer relaunches after a silent install', () {
    final iss = File('windows/installer/gramnota.iss').readAsStringSync();
    final run = iss.split('[Run]').last;
    expect(run, contains(r'{#AppExe}'));
    expect(run.toLowerCase(), isNot(contains('skipifsilent')));
    expect(windowsInstallerArguments, [
      '/SILENT',
      '/SUPPRESSMSGBOXES',
      '/NORESTART',
    ]);
  });

  testWidgets('the update dialog is in Swedish', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UpdateOfferDialog(
            artifact: UpdateArtifact(
              version: '1.0.0',
              build: 8,
              commit: 'abc',
              date: '2026-10-19',
              notes: 'Bättre lager.',
              url: 'https://example.test/Gramnota.apk',
              sha256: 'ab' * 32,
            ),
          ),
        ),
      ),
    );
    expect(find.text('Ny version 1.0.0 finns'), findsOneWidget);
    expect(find.text('Bättre lager.'), findsOneWidget);
    expect(find.text('Uppdatera'), findsOneWidget);
    expect(find.text('Senare'), findsOneWidget);
    expect(find.text('Hoppa över denna version'), findsOneWidget);
  });

  testWidgets('settings can show the search button with a known version', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UpdateSection(versionLabel: 'Version 1.0.0 (build 1)'),
        ),
      ),
    );
    expect(find.text('Version 1.0.0 (build 1)'), findsOneWidget);
    expect(find.text('Sök efter uppdateringar'), findsOneWidget);
  });
}

class _RealHttpOverrides extends HttpOverrides {}

Future<void> _downloadFromLocalServer() async {
  final bytes = utf8.encode('gramnota-apk');
  final digest = sha256.convert(bytes).toString();
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  final root = 'http://${server.address.host}:${server.port}';
  final manifest = utf8.encode(
    jsonEncode({
      'version': '1.0.0',
      'android': {
        'build': 20,
        'commit': 'abc1234',
        'date': '2026-10-19',
        'notes': 'Ny version.',
        'url': '$root/Gramnota.apk',
        'sha256': digest,
      },
    }),
  );
  server.listen((request) async {
    final List<int>? body = switch (request.uri.path) {
      '/latest.json' => manifest,
      '/Gramnota.apk' => bytes,
      _ => null,
    };
    if (body == null) {
      request.response.statusCode = HttpStatus.notFound;
    } else {
      request.response.statusCode = HttpStatus.ok;
      request.response.contentLength = body.length;
      request.response.add(body);
    }
    await request.response.close();
  });
  final httpClient = http.Client();
  addTearDown(() async {
    httpClient.close();
    await server.close(force: true);
  });

  final client = UpdateClient(
    client: httpClient,
    manifestUrl: '$root/latest.json',
  );
  final outcome = await UpdateCoordinator(
    client: client,
    preferences: MemoryUpdatePreferences(),
    platform: UpdatePlatform.android,
    installedBuild: 1,
    now: () => DateTime.utc(2026, 10, 19),
  ).check(manual: false);
  expect(outcome.artifact?.build, 20);
  expect(outcome.artifact?.notes, 'Ny version.');

  final file = File(
    '${Directory.systemTemp.path}/gramnota-update-test/Gramnota.apk',
  );
  final saved = await client.download(
    url: outcome.artifact!.url,
    sha256: digest,
    destination: file,
  );
  expect(await saved.readAsBytes(), bytes);
  expect(File('${file.path}.part').existsSync(), isFalse);

  await expectLater(
    client.download(
      url: outcome.artifact!.url,
      sha256: 'cd' * 32,
      destination: file,
    ),
    throwsA(isA<UpdateChecksumException>()),
  );
  expect(File('${file.path}.part').existsSync(), isFalse);
  expect(await file.readAsBytes(), bytes);

  final missing = UpdateClient(
    client: httpClient,
    manifestUrl: '$root/missing.json',
  );
  await expectLater(
    missing.fetchManifest(),
    throwsA(isA<UpdateManifestException>()),
  );

  final port = server.port;
  await server.close(force: true);
  final offline = UpdateClient(
    client: httpClient,
    manifestUrl: 'http://127.0.0.1:$port/latest.json',
  );
  await expectLater(
    offline.fetchManifest(),
    throwsA(isA<UpdateNetworkException>()),
  );
}

UpdateManifest _manifest({required int build, bool windowsOnly = false}) {
  final artifact = UpdateArtifact(
    version: '1.0.0',
    build: build,
    commit: 'abc',
    date: '2026-10-19',
    notes: 'Notes',
    url: 'https://example.test/file',
    sha256: 'ab' * 32,
  );
  return UpdateManifest(
    version: '1.0.0',
    android: windowsOnly ? null : artifact,
    windows: artifact,
  );
}

class _FakeSource implements ManifestSource {
  _FakeSource(this.manifest, {this.error});

  UpdateManifest manifest;
  Object? error;
  var fetches = 0;

  @override
  Future<UpdateManifest> fetchManifest() async {
    fetches += 1;
    final failure = error;
    if (failure != null) {
      throw failure;
    }
    return manifest;
  }
}
