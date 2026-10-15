// Placeholder until `flutterfire configure` overwrites this file.
// The app treats an apiKey that starts with REPLACE as "not configured".
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      // Windows is registered as a Firebase web app, so the browser uses it too.
      return windows;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.windows:
        return windows;
      default:
        throw UnsupportedError(
          'Gramnota is set up for Android and Windows.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAqD00513zk9kdB9LeyM3_e0pXsE7FwmDA',
    appId: '1:877210506403:android:1ceb0b0dc89a303655db16',
    messagingSenderId: '877210506403',
    projectId: 'gramnota-2c353',
    storageBucket: 'gramnota-2c353.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCYwapnkaSAfWdShhtl0dy6UkZt10bUlBY',
    appId: '1:877210506403:web:fe938bab702adcc355db16',
    messagingSenderId: '877210506403',
    projectId: 'gramnota-2c353',
    authDomain: 'gramnota-2c353.firebaseapp.com',
    storageBucket: 'gramnota-2c353.firebasestorage.app',
    measurementId: 'G-5F53T8QMLJ',
  );
}

bool get firebaseIsConfigured =>
    !DefaultFirebaseOptions.android.apiKey.startsWith('REPLACE') &&
    !DefaultFirebaseOptions.windows.apiKey.startsWith('REPLACE');
