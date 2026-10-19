import 'dart:async';
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
import 'package:gramnota/features/updates/presentation/update_launcher.dart';
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
      'Kunde inte läsa uppdateringsinformationen. (bad)',
    );
    expect(
      updateFailureMessage(StateError('x')),
      'Kunde inte söka efter uppdateringar. (Bad state: x)',
    );
    expect(
      updateFailureMessage(
        const UpdateNetworkException('SocketException: reset'),
      ),
      'Ingen internetanslutning. Försök igen senare. (SocketException: reset)',
    );
    expect(
      updateFailureMessage(const UpdateManifestException('HTTP 302')),
      'Kunde inte läsa uppdateringsinformationen. (HTTP 302)',
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
    expect(current.message, 'You have the latest version (build 1)');
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
    final launchLine = run
        .split('\n')
        .firstWhere((line) => line.startsWith('Filename:'));
    expect(launchLine, contains(r'{#AppExe}'));
    expect(launchLine.toLowerCase(), isNot(contains('skipifsilent')));
    expect(run, contains('WizardShouldLaunchApp'));
    expect(run, contains('{param:NORUN|0}'));
    expect(windowsInstallerArguments, [
      '/SILENT',
      '/SUPPRESSMSGBOXES',
      '/NORESTART',
    ]);
    expect(windowsInstallerArguments.join(' '), isNot(contains('NORUN')));
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

  test(
    'a redirecting octet-stream manifest offers the newer android build',
    () async {
      const notes = 'Ny version å';
      final payload = utf8.encode(
        jsonEncode({
          'version': '1.0.0',
          'android': {
            'build': 17,
            'commit': 'abc',
            'date': '2026-10-19',
            'notes': notes,
            'url': 'https://example.test/Gramnota.apk',
            'sha256': 'ab' * 32,
          },
        }),
      );
      final redirecting = _RedirectingClient(payload);
      final client = UpdateClient(
        client: redirecting,
        manifestUrl: 'https://example.test/latest.json',
      );
      final newer = await UpdateCoordinator(
        client: client,
        preferences: MemoryUpdatePreferences(),
        platform: UpdatePlatform.android,
        installedBuild: 16,
        now: () => DateTime.utc(2026, 10, 19),
      ).check(manual: true);
      expect(redirecting.redirects, 1);
      expect(newer.artifact?.build, 17);
      expect(newer.artifact?.notes, notes);

      final current = await UpdateCoordinator(
        client: client,
        preferences: MemoryUpdatePreferences(),
        platform: UpdatePlatform.android,
        installedBuild: 17,
        now: () => DateTime.utc(2026, 10, 19),
      ).check(manual: true);
      expect(current.upToDate, isTrue);
      expect(current.message, 'You have the latest version (build 17)');

      final missing = UpdateClient(
        client: _StatusClient(500),
        manifestUrl: 'https://example.test/latest.json',
      );
      await expectLater(
        missing.fetchManifest(),
        throwsA(
          isA<UpdateManifestException>().having(
            (error) => error.detail,
            'detail',
            'HTTP 500',
          ),
        ),
      );
    },
  );

  test('a redirected download keeps the file bytes', () async {
    final bytes = utf8.encode('gramnota-apk');
    final digest = sha256.convert(bytes).toString();
    final client = UpdateClient(
      client: _RedirectingClient(bytes, path: '/Gramnota.apk'),
      manifestUrl: 'https://example.test/latest.json',
    );
    final file = File(
      '${Directory.systemTemp.path}/gramnota-update-redirect/Gramnota.apk',
    );
    final saved = await client.download(
      url: 'https://example.test/Gramnota.apk',
      sha256: digest,
      destination: file,
    );
    expect(await saved.readAsBytes(), bytes);
    if (file.existsSync()) {
      await file.delete();
    }
  });

  testWidgets('checking shows a spinner and then the latest-version message', (
    tester,
  ) async {
    final gate = Completer<void>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UpdateSection(
            versionLabel: 'Version 1.0.0 (build 16)',
            prompt: (context) async {
              await gate.future;
              return const UpdatePromptResult(
                message: 'You have the latest version (build 16)',
              );
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('Sök efter uppdateringar'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Söker…'), findsOneWidget);
    gate.complete();
    await tester.pump();
    await tester.pump();
    expect(find.text('You have the latest version (build 16)'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('a failed search stays on screen with the reason', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UpdateSection(
            versionLabel: 'Version 1.0.0 (build 16)',
            prompt: (context) async {
              throw StateError('plugin missing');
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('Sök efter uppdateringar'));
    await tester.pump();
    await tester.pump();
    expect(find.textContaining('plugin missing'), findsOneWidget);
    expect(
      find.textContaining('Kunde inte söka efter uppdateringar'),
      findsOneWidget,
    );
  });

  testWidgets('an android build 16 check offers build 17 from the manifest', (
    tester,
  ) async {
    final gate = Completer<void>();
    final coordinator = UpdateCoordinator(
      client: _DelayedSource(_manifest(build: 17), gate),
      preferences: MemoryUpdatePreferences(),
      platform: UpdatePlatform.android,
      installedBuild: 16,
      now: () => DateTime.utc(2026, 10, 19),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UpdateSection(
            versionLabel: 'Version 1.0.0 (build 16)',
            prompt: (context) => promptForUpdate(
              context,
              manual: true,
              coordinator: coordinator,
              onReady: () {},
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Sök efter uppdateringar'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsWidgets);
    gate.complete();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Ny version 1.0.0 finns'), findsOneWidget);
    await tester.tap(find.text('Senare'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Ny version 1.0.0 finns'), findsNothing);
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

class _DelayedSource implements ManifestSource {
  _DelayedSource(this.manifest, this.gate);

  final UpdateManifest manifest;
  final Completer<void> gate;

  @override
  Future<UpdateManifest> fetchManifest() async {
    await gate.future;
    return manifest;
  }
}

/// Returns 302 for the first hop and an octet-stream body for the next.
class _RedirectingClient extends http.BaseClient {
  _RedirectingClient(this.payload, {this.path = '/latest.json'});

  final List<int> payload;
  final String path;
  var redirects = 0;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (request.url.path == path) {
      redirects += 1;
      return http.StreamedResponse(
        http.ByteStream.fromBytes(const <int>[]),
        302,
        headers: {
          'location': request.url.replace(path: '/payload').toString(),
          'content-type': 'text/html; charset=utf-8',
        },
      );
    }
    return http.StreamedResponse(
      http.ByteStream.fromBytes(payload),
      200,
      headers: {'content-type': 'application/octet-stream'},
      contentLength: payload.length,
    );
  }
}

class _StatusClient extends http.BaseClient {
  _StatusClient(this.statusCode);

  final int statusCode;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return http.StreamedResponse(
      http.ByteStream.fromBytes(const <int>[]),
      statusCode,
    );
  }
}
