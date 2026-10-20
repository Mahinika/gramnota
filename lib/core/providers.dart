import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gramnota/l10n/l10n.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../features/auth/data/desktop_google_sign_in.dart';
import '../features/import/domain/slice_file.dart';
import '../firebase_options.dart';
import 'firebase_emulator.dart';
import 'user_store.dart';

final authUserProvider = StreamProvider<User?>((ref) {
  if (!firebaseIsConfigured) {
    return Stream<User?>.value(null);
  }
  return FirebaseAuth.instance.authStateChanges();
});

final userStoreProvider = Provider<UserStore?>((ref) {
  if (!firebaseIsConfigured) {
    return null;
  }
  final user = ref.watch(authUserProvider).asData?.value;
  if (user == null) {
    return null;
  }
  return UserStore(FirebaseFirestore.instance, user.uid);
});

class PendingLink extends Notifier<String?> {
  @override
  String? build() => null;

  void setLink(String? value) => state = value;
}

final pendingLinkProvider = NotifierProvider<PendingLink, String?>(
  PendingLink.new,
);

class PendingSlice extends Notifier<String?> {
  @override
  String? build() => null;

  void setPath(String? value) => state = value;
}

final pendingSliceProvider = NotifierProvider<PendingSlice, String?>(
  PendingSlice.new,
);

bool get _isAndroid => !kIsWeb && Platform.isAndroid;

bool get _isWindows => !kIsWeb && Platform.isWindows;

final sharedLinkBootstrapProvider = Provider<void>((ref) {
  if (!_isAndroid) {
    return;
  }
  final subscription = ReceiveSharingIntent.instance.getMediaStream().listen((
    files,
  ) {
    _captureShare(ref, files);
  });
  ref.onDispose(subscription.cancel);
  ReceiveSharingIntent.instance.getInitialMedia().then((files) async {
    _captureShare(ref, files);
    await ReceiveSharingIntent.instance.reset();
  });
});

void _captureShare(Ref ref, List<SharedMediaFile> files) {
  final slice = sharedSlicePath(files);
  if (slice != null) {
    ref.read(pendingSliceProvider.notifier).setPath(slice);
    return;
  }
  final link = sharedText(files);
  if (link != null) {
    ref.read(pendingLinkProvider.notifier).setLink(link);
  }
}

String? sharedSlicePath(List<SharedMediaFile> files) {
  for (final file in files) {
    if (isSliceFileName(file.path)) {
      return file.path;
    }
  }
  return null;
}

String? sharedText(List<SharedMediaFile> files) {
  for (final file in files) {
    final candidates = [file.path, file.message ?? ''];
    for (final candidate in candidates) {
      final text = candidate.trim();
      if (text.startsWith('http://') || text.startsWith('https://')) {
        return text;
      }
    }
  }
  return null;
}

Future<AuthCredential> googleAuthCredential({bool darkPage = false}) async {
  if (_isAndroid) {
    final account = await GoogleSignIn.instance.authenticate();
    return GoogleAuthProvider.credential(
      idToken: account.authentication.idToken,
    );
  }
  if (_isWindows) {
    // signInWithProvider is rejected by the Firebase C++ SDK on Windows.
    final options = DefaultFirebaseOptions.windows;
    final tokens = await requestDesktopGoogleCredential(
      apiKey: options.apiKey,
      authDomain: options.authDomain ?? 'gramnota-2c353.firebaseapp.com',
      projectId: options.projectId,
      appId: options.appId,
      storageBucket: options.storageBucket,
      dark: darkPage,
    );
    return GoogleAuthProvider.credential(
      idToken: tokens.idToken,
      accessToken: tokens.accessToken,
    );
  }
  throw SignInFailed(activeGramnotaL10n.authGooglePlatforms);
}

Future<void> signInWithGoogle({bool darkPage = false}) async {
  final credential = await FirebaseAuth.instance.signInWithCredential(
    await googleAuthCredential(darkPage: darkPage),
  );
  await _rememberSignedInUser(credential.user);
}

/// Asks Google (or the emulator tester) to sign in again, then refreshes
/// the current user. Account deletion calls this before it touches data.
Future<void> reauthenticateCurrentUser({bool darkPage = false}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw FirebaseAuthException(code: 'requires-recent-login');
  }
  final AuthCredential credential;
  if (useFirebaseEmulator &&
      (user.email ?? '').trim().toLowerCase() == emulatorTesterEmail) {
    credential = EmailAuthProvider.credential(
      email: emulatorTesterEmail,
      password: emulatorTesterPassword,
    );
  } else {
    credential = await googleAuthCredential(darkPage: darkPage);
  }
  await user.reauthenticateWithCredential(credential);
}

/// Email sign-in for the local Auth emulator only. The button is compiled in
/// when [useFirebaseEmulator] is true, and the call is a no-op otherwise.
Future<void> signInWithEmulatorTester() async {
  if (!useFirebaseEmulator) {
    return;
  }
  UserCredential credential;
  try {
    credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emulatorTesterEmail,
      password: emulatorTesterPassword,
    );
  } on FirebaseAuthException catch (error) {
    const missing = {
      'user-not-found',
      'invalid-credential',
      'invalid-login-credentials',
    };
    if (!missing.contains(error.code)) {
      rethrow;
    }
    credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emulatorTesterEmail,
      password: emulatorTesterPassword,
    );
    await credential.user?.updateDisplayName(emulatorTesterName);
    await credential.user?.reload();
    credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emulatorTesterEmail,
      password: emulatorTesterPassword,
    );
  }
  final tester = credential.user;
  if (tester != null) {
    await markEmulatorEmailVerified(tester.uid);
    await tester.getIdToken(true);
  }
  await _rememberSignedInUser(credential.user);
}

Future<void> _rememberSignedInUser(User? user) async {
  final email = user?.email;
  if (user == null || email == null) {
    return;
  }
  await UserStore(
    FirebaseFirestore.instance,
    user.uid,
  ).ensureDirectory(email: email, displayName: user.displayName ?? email);
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  if (_isAndroid) {
    await GoogleSignIn.instance.signOut();
  }
}
