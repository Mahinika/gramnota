import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:url_launcher/url_launcher.dart';

import '../domain/sign_in_failed.dart';

export '../domain/sign_in_failed.dart';

const _firebaseJs = '11.6.1';

/// Opens the system browser on a localhost page and waits for Google tokens.
///
/// Firebase Auth's Windows SDK rejects `signInWithProvider` ("Operation is not
/// supported on non-mobile systems"). The page uses the Firebase web SDK,
/// which is allowed for `localhost`, then posts the Google ID token back here
/// so the desktop app can call `signInWithCredential`.
Future<DesktopGoogleCredential> requestDesktopGoogleCredential({
  required String apiKey,
  required String authDomain,
  required String projectId,
  required String appId,
  String? storageBucket,
  Future<bool> Function(Uri url)? openBrowser,
  Duration timeout = const Duration(minutes: 5),
}) async {
  final nonce = newSignInNonce();
  final page = desktopGoogleSignInPage(
    apiKey: apiKey,
    authDomain: authDomain,
    projectId: projectId,
    appId: appId,
    storageBucket: storageBucket,
    nonce: nonce,
  );
  final v4 = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  final servers = <HttpServer>[v4];
  try {
    servers.add(await HttpServer.bind(InternetAddress.loopbackIPv6, v4.port));
  } on SocketException {
    // IPv4 loopback is enough when localhost resolves to 127.0.0.1.
  }
  final completer = Completer<_BrowserReply>();
  for (final server in servers) {
    server.listen((request) {
      unawaited(
        _handleSignInRequest(
          request,
          page: page,
          nonce: nonce,
          completer: completer,
        ),
      );
    }, onError: (Object _) {});
  }
  // Listen before the browser opens so a fast callback is not an unhandled error.
  final result = completer.future.timeout(
    timeout,
    onTimeout: () {
      throw const SignInFailed(
        'Sign-in timed out. Finish it in the browser, or try again.',
      );
    },
  );
  try {
    final url = Uri.parse('http://localhost:${v4.port}/');
    final opened = await (openBrowser ?? openDesktopBrowser)(url);
    if (!opened && !completer.isCompleted) {
      completer.complete(
        const _BrowserReply.fail(
          SignInFailed('Could not open the browser. Try again.'),
        ),
      );
    }
    final reply = await result;
    final failure = reply.failure;
    if (failure != null) {
      throw failure;
    }
    return reply.credential!;
  } finally {
    for (final server in servers) {
      await server.close(force: true);
    }
  }
}

Future<bool> openDesktopBrowser(Uri url) {
  return launchUrl(url, mode: LaunchMode.externalApplication);
}

String newSignInNonce() {
  final random = Random.secure();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));
  return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}

/// The localhost page. [nonce] must match the POST or the token is ignored.
String desktopGoogleSignInPage({
  required String apiKey,
  required String authDomain,
  required String projectId,
  required String appId,
  required String nonce,
  String? storageBucket,
}) {
  final config = jsonEncode({
    'apiKey': apiKey,
    'authDomain': authDomain,
    'projectId': projectId,
    'appId': appId,
    'storageBucket': ?storageBucket,
  }).replaceAll('<', r'\u003c');
  final nonceLiteral = jsonEncode(nonce).replaceAll('<', r'\u003c');
  return '''
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Gramnota sign-in</title>
<style>
  body { margin: 0; min-height: 100vh; display: flex; align-items: center; justify-content: center;
    background: #F6F3EC; color: #1A1F1C; font-family: "Segoe UI", sans-serif; }
  main { max-width: 360px; padding: 32px 24px; text-align: center; }
  h1 { font-size: 28px; font-weight: 600; margin: 0 0 12px; }
  p { margin: 0 0 20px; line-height: 1.4; }
  button { background: #0F6E56; color: #fff; border: 0; border-radius: 999px;
    padding: 12px 20px; font-size: 16px; cursor: pointer; }
  button:disabled { opacity: 0.6; cursor: default; }
</style>
</head>
<body>
<main>
  <h1>Gramnota</h1>
  <p id="status">Opening Google…</p>
  <button id="go" type="button" hidden>Continue with Google</button>
</main>
<script src="https://www.gstatic.com/firebasejs/$_firebaseJs/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/$_firebaseJs/firebase-auth-compat.js"></script>
<script>
const config = $config;
const nonce = $nonceLiteral;
const statusEl = document.getElementById('status');
const button = document.getElementById('go');
const provider = new firebase.auth.GoogleAuthProvider();
provider.setCustomParameters({prompt: 'select_account'});
firebase.initializeApp(config);

function show(message) { statusEl.textContent = message; }

function post(body) {
  return fetch('/result', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(Object.assign({nonce: nonce}, body)),
  });
}

async function succeed(result) {
  let credential = result && result.credential;
  if (!credential && firebase.auth.GoogleAuthProvider.credentialFromResult) {
    credential = firebase.auth.GoogleAuthProvider.credentialFromResult(result);
  }
  const idToken = credential && credential.idToken || '';
  const accessToken = credential && credential.accessToken || '';
  if (!idToken && !accessToken) {
    show('Google did not return a sign-in token.');
    await post({code: 'no-token'});
    return;
  }
  await post({idToken: idToken, accessToken: accessToken});
  show('Signed in. You can close this window and return to Gramnota.');
  button.hidden = true;
}

function fail(code) {
  const messages = {
    'unauthorized-domain': 'Google sign-in is not allowed from this page.',
    'no-token': 'Google did not return a sign-in token.',
    'cancelled': 'Sign-in was cancelled.',
    'failed': 'Sign-in failed. Try again.'
  };
  show(messages[code] || messages.failed);
  return post({code: code === 'unauthorized-domain' || code === 'no-token' || code === 'cancelled' ? code : 'failed'});
}

button.addEventListener('click', async () => {
  button.disabled = true;
  try {
    const result = await firebase.auth().signInWithPopup(provider);
    await succeed(result);
  } catch (error) {
    const code = error && error.code || '';
    if (code === 'auth/popup-closed-by-user' || code === 'auth/cancelled-popup-request') {
      button.disabled = false;
      show('Sign-in was cancelled. Try again.');
      return;
    }
    if (code === 'auth/unauthorized-domain') {
      await fail('unauthorized-domain');
      return;
    }
    button.disabled = false;
    await fail('failed');
  }
});

firebase.auth().getRedirectResult().then(async (result) => {
  if (result && result.user) {
    await succeed(result);
    return;
  }
  if (sessionStorage.getItem('gramnota-redirect') === '1') {
    show('Continue with Google to finish sign-in.');
    button.hidden = false;
    return;
  }
  sessionStorage.setItem('gramnota-redirect', '1');
  try {
    await firebase.auth().signInWithRedirect(provider);
  } catch (error) {
    button.hidden = false;
    const code = error && error.code || '';
    if (code === 'auth/unauthorized-domain') {
      await fail('unauthorized-domain');
      return;
    }
    show('Continue with Google to finish sign-in.');
  }
}).catch(async (error) => {
  button.hidden = false;
  const code = error && error.code || '';
  if (code === 'auth/redirect-cancelled-by-user' || code === 'auth/user-cancelled') {
    show('Sign-in was cancelled. Try again.');
    return;
  }
  await fail('failed');
});
</script>
</body>
</html>
''';
}

/// Reads the browser POST. A wrong nonce throws [DesktopGoogleRejected].
DesktopGoogleCredential parseDesktopGooglePost(
  String body, {
  required String nonce,
}) {
  final Object? decoded;
  try {
    decoded = jsonDecode(body);
  } on FormatException {
    throw const FormatException('Sign-in response was not valid.');
  }
  if (decoded is! Map) {
    throw const FormatException('Sign-in response was not valid.');
  }
  if (decoded['nonce'] != nonce) {
    throw const DesktopGoogleRejected();
  }
  final code = decoded['code'];
  if (code is String && code.isNotEmpty) {
    throw SignInFailed(_messageForCode(code));
  }
  final idToken = _token(decoded['idToken']);
  final accessToken = _token(decoded['accessToken']);
  if (idToken == null && accessToken == null) {
    throw const SignInFailed('Google did not return a sign-in token.');
  }
  return DesktopGoogleCredential(idToken: idToken, accessToken: accessToken);
}

class DesktopGoogleRejected implements Exception {
  const DesktopGoogleRejected();
}

/// A browser callback. Failures stay values so the HTTP zone does not see an
/// unhandled [SignInFailed].
class _BrowserReply {
  const _BrowserReply.ok(this.credential) : failure = null;

  const _BrowserReply.fail(this.failure) : credential = null;

  final DesktopGoogleCredential? credential;
  final SignInFailed? failure;
}

String _messageForCode(String code) {
  switch (code) {
    case 'cancelled':
      return 'Sign-in was cancelled.';
    case 'unauthorized-domain':
      return 'Google sign-in is not allowed from this page.';
    case 'no-token':
      return 'Google did not return a sign-in token.';
    default:
      return 'Sign-in failed. Try again.';
  }
}

String? _token(Object? value) {
  if (value is! String) {
    return null;
  }
  final trimmed = value.trim();
  if (trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}

Future<void> _handleSignInRequest(
  HttpRequest request, {
  required String page,
  required String nonce,
  required Completer<_BrowserReply> completer,
}) async {
  try {
    if (!_loopbackHost(request)) {
      request.response.statusCode = HttpStatus.forbidden;
      await request.response.close();
      return;
    }
    request.response.headers.set('Cache-Control', 'no-store');
    request.response.headers.set('X-Content-Type-Options', 'nosniff');
    if (request.method == 'GET') {
      request.response.headers.contentType = ContentType.html;
      request.response.write(page);
      await request.response.close();
      return;
    }
    if (request.method != 'POST' || request.uri.path != '/result') {
      request.response.statusCode = HttpStatus.notFound;
      await request.response.close();
      return;
    }
    final body = await _readBody(request);
    if (body == null) {
      request.response.statusCode = HttpStatus.requestEntityTooLarge;
      await request.response.close();
      return;
    }
    Object? outcome;
    try {
      outcome = parseDesktopGooglePost(body, nonce: nonce);
      request.response.statusCode = HttpStatus.noContent;
    } on DesktopGoogleRejected {
      request.response.statusCode = HttpStatus.forbidden;
    } on SignInFailed catch (error) {
      outcome = error;
      request.response.statusCode = HttpStatus.noContent;
    } on FormatException {
      request.response.statusCode = HttpStatus.badRequest;
    }
    await request.response.close();
    if (!completer.isCompleted) {
      switch (outcome) {
        case final DesktopGoogleCredential credential:
          completer.complete(_BrowserReply.ok(credential));
        case final SignInFailed failure:
          completer.complete(_BrowserReply.fail(failure));
        case null:
          break;
      }
    }
  } on Object {
    try {
      await request.response.close();
    } on Object {
      // The browser already went away.
    }
  }
}

bool _loopbackHost(HttpRequest request) {
  final raw = request.headers.host ?? '';
  final String hostname;
  if (raw.startsWith('[')) {
    final end = raw.indexOf(']');
    if (end < 0) {
      return false;
    }
    hostname = raw.substring(1, end);
  } else {
    hostname = raw.split(':').first;
  }
  return hostname == 'localhost' ||
      hostname == '127.0.0.1' ||
      hostname == '::1';
}

Future<String?> _readBody(HttpRequest request) async {
  final builder = BytesBuilder(copy: false);
  await for (final chunk in request) {
    if (builder.length + chunk.length > 16384) {
      return null;
    }
    builder.add(chunk);
  }
  return utf8.decode(builder.takeBytes());
}
