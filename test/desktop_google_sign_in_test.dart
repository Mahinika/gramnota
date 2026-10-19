import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/auth/data/desktop_google_sign_in_io.dart';
import 'package:intl/intl.dart';

void main() {
  setUp(() {
    Intl.defaultLocale = 'en';
  });

  test('sign-in page embeds Firebase web config and the nonce', () {
    final page = desktopGoogleSignInPage(
      apiKey: 'key-<not-html>',
      authDomain: 'gramnota-2c353.firebaseapp.com',
      projectId: 'gramnota-2c353',
      appId: '1:877210506403:web:abc',
      nonce: 'abc123',
    );
    expect(page, contains('firebase-auth-compat.js'));
    expect(page, contains('signInWithRedirect'));
    expect(page, contains('signInWithPopup'));
    expect(page, isNot(contains('signInWithProvider')));
    expect(page, contains(r'key-\u003cnot-html>'));
    expect(page, contains('const nonce = "abc123"'));
    expect(page, contains('gramnota-2c353.firebaseapp.com'));
  });

  test('parses tokens and rejects a mismatched nonce', () {
    final credential = parseDesktopGooglePost(
      '{"nonce":"n","idToken":"id","accessToken":"access"}',
      nonce: 'n',
    );
    expect(credential.idToken, 'id');
    expect(credential.accessToken, 'access');

    expect(
      () => parseDesktopGooglePost(
        '{"nonce":"other","idToken":"id"}',
        nonce: 'n',
      ),
      throwsA(isA<DesktopGoogleRejected>()),
    );
    expect(
      () => parseDesktopGooglePost(
        '{"nonce":"n","code":"cancelled"}',
        nonce: 'n',
      ),
      throwsA(
        isA<SignInFailed>().having(
          (error) => error.message,
          'message',
          'Sign-in was cancelled.',
        ),
      ),
    );
    expect(
      () => parseDesktopGooglePost(
        '{"nonce":"n","code":"not-a-real-code"}',
        nonce: 'n',
      ),
      throwsA(
        isA<SignInFailed>().having(
          (error) => error.message,
          'message',
          'Sign-in failed. Try again.',
        ),
      ),
    );
  });

  test('browser posts tokens to the localhost page', () async {
    final credential = await requestDesktopGoogleCredential(
      apiKey: 'test-key',
      authDomain: 'gramnota-2c353.firebaseapp.com',
      projectId: 'gramnota-2c353',
      appId: '1:1:web:abc',
      openBrowser: (url) async {
        final client = HttpClient();
        try {
          final page = await _get(client, url);
          expect(page, contains('Opening Google'));
          final nonce = RegExp(
            r'const nonce = "([0-9a-f]{32})"',
          ).firstMatch(page)!.group(1)!;
          final rejected = await _post(
            client,
            url.replace(path: '/result'),
            '{"nonce":"nope","idToken":"stolen"}',
          );
          expect(rejected, HttpStatus.forbidden);
          final accepted = await _post(
            client,
            url.replace(path: '/result'),
            jsonEncode({
              'nonce': nonce,
              'idToken': 'google-id',
              'accessToken': 'google-access',
            }),
          );
          expect(accepted, HttpStatus.noContent);
        } finally {
          client.close(force: true);
        }
        return true;
      },
    );

    expect(credential.idToken, 'google-id');
    expect(credential.accessToken, 'google-access');
  });

  test('a browser error ends sign-in with that message', () async {
    await expectLater(
      requestDesktopGoogleCredential(
        apiKey: 'test-key',
        authDomain: 'gramnota-2c353.firebaseapp.com',
        projectId: 'gramnota-2c353',
        appId: '1:1:web:abc',
        openBrowser: (url) async {
          final client = HttpClient();
          try {
            final page = await _get(client, url);
            final nonce = RegExp(
              r'const nonce = "([0-9a-f]{32})"',
            ).firstMatch(page)!.group(1)!;
            await _post(
              client,
              url.replace(path: '/result'),
              jsonEncode({'nonce': nonce, 'code': 'no-token'}),
            );
          } finally {
            client.close(force: true);
          }
          return true;
        },
      ),
      throwsA(
        isA<SignInFailed>().having(
          (error) => error.message,
          'message',
          'Google did not return a sign-in token.',
        ),
      ),
    );
  });

  test('sign-in times out when the browser never answers', () async {
    await expectLater(
      requestDesktopGoogleCredential(
        apiKey: 'test-key',
        authDomain: 'gramnota-2c353.firebaseapp.com',
        projectId: 'gramnota-2c353',
        appId: '1:1:web:abc',
        timeout: const Duration(milliseconds: 50),
        openBrowser: (url) async => true,
      ),
      throwsA(
        isA<SignInFailed>().having(
          (error) => error.message,
          'message',
          'Sign-in timed out. Finish it in the browser, or try again.',
        ),
      ),
    );
  });
}

Future<String> _get(HttpClient client, Uri url) async {
  final request = await client.getUrl(url);
  final response = await request.close();
  expect(response.statusCode, HttpStatus.ok);
  return response.transform(utf8.decoder).join();
}

Future<int> _post(HttpClient client, Uri url, String body) async {
  final request = await client.postUrl(url);
  request.headers.contentType = ContentType.json;
  request.add(utf8.encode(body));
  final response = await request.close();
  await response.drain<void>();
  return response.statusCode;
}
