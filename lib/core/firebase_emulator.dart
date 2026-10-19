import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'emulator_session_stub.dart'
    if (dart.library.js_interop) 'emulator_session_web.dart';

/// Compile-time flag. Pass `--dart-define=USE_FIREBASE_EMULATOR=true`.
/// Production builds leave this false and never touch the emulators.
const useFirebaseEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');

const firebaseEmulatorHost = String.fromEnvironment(
  'FIREBASE_EMULATOR_HOST',
  defaultValue: '127.0.0.1',
);

const firebaseAuthEmulatorPort = 9099;
const firebaseFirestoreEmulatorPort = 8080;

/// Local account created on the Auth emulator. Not a production credential.
const emulatorTesterEmail = 'seller@gramnota.test';
const emulatorTesterPassword = 'gramnota-test';
const emulatorTesterName = 'Test seller';

/// The Auth emulator creates the tester with `email_verified` false.
/// Directory writes and inbox creates require a verified email, which Google
/// sign-in already has. This marks the local tester so sharing still works.
Future<void> markEmulatorEmailVerified(String localId) async {
  if (!useFirebaseEmulator || localId.isEmpty) {
    return;
  }
  final uri = Uri(
    scheme: 'http',
    host: firebaseEmulatorHost,
    port: firebaseAuthEmulatorPort,
    path: '/identitytoolkit.googleapis.com/v1/accounts:update',
  );
  final response = await http.post(
    uri,
    headers: const {
      'Authorization': 'Bearer owner',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'localId': localId,
      'emailVerified': true,
    }),
  );
  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw StateError(
      'Could not mark the emulator tester email verified '
      '(${response.statusCode}).',
    );
  }
}

Future<void> connectFirebaseEmulators() async {
  clearAuthEmulatorSession();
  await FirebaseAuth.instance.useAuthEmulator(
    firebaseEmulatorHost,
    firebaseAuthEmulatorPort,
  );
  try {
    FirebaseFirestore.instance.useFirestoreEmulator(
      firebaseEmulatorHost,
      firebaseFirestoreEmulatorPort,
    );
  } on Object catch (error) {
    if (!error.toString().contains('already')) {
      rethrow;
    }
  }
}
