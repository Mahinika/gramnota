import 'dart:js_interop';
import 'dart:js_interop_unsafe';

/// firebase_auth_web skips [FirebaseAuth.useAuthEmulator] when this key is
/// already set, and it only restores the emulator automatically when the page
/// host is exactly "localhost". Clearing it makes the next call connect again
/// after a refresh on 127.0.0.1.
void clearAuthEmulatorSession() {
  final storage = globalContext['sessionStorage'] as JSObject;
  storage.callMethod(
    'removeItem'.toJS,
    '[DEFAULT]-firebaseEmulatorOrigin'.toJS,
  );
}
