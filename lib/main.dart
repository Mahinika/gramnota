import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'app.dart';
import 'core/firebase_emulator.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (firebaseIsConfigured) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    if (useFirebaseEmulator) {
      await connectFirebaseEmulators();
    }
    FirebaseFirestore.instance.settings = Settings(
      persistenceEnabled: !useFirebaseEmulator,
    );
    if (!kIsWeb && Platform.isAndroid) {
      await GoogleSignIn.instance.initialize();
    }
  }
  runApp(const ProviderScope(child: GramnotaApp()));
}
