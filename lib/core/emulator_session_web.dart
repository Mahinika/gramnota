import 'dart:js_interop';
import 'dart:js_interop_unsafe';

/// firebase_auth_web skips [FirebaseAuth.useAuthEmulator] when this key already
/// matches the emulator origin, and it only restores that origin automatically
/// when the page host is exactly "localhost". On 127.0.0.1 a skipped call
/// leaves Auth pointed at production. Drop every saved origin so the next
/// `useAuthEmulator` actually reaches the JS SDK.
void clearAuthEmulatorSession() {
  globalContext.callMethod(
    'eval'.toJS,
    r'''
(function () {
  var storage = window.sessionStorage;
  if (!storage) return;
  var keys = [];
  for (var i = 0; i < storage.length; i++) keys.push(storage.key(i));
  for (var j = 0; j < keys.length; j++) {
    var key = keys[j];
    if (key && key.indexOf('firebaseEmulatorOrigin') !== -1) {
      storage.removeItem(key);
    }
  }
})()
'''.toJS,
  );
}
