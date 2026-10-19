import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

Future<void> connectFirebaseEmulators() async {
  await FirebaseAuth.instance.useAuthEmulator(
    firebaseEmulatorHost,
    firebaseAuthEmulatorPort,
  );
  FirebaseFirestore.instance.useFirestoreEmulator(
    firebaseEmulatorHost,
    firebaseFirestoreEmulatorPort,
  );
}
