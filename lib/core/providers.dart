import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../firebase_options.dart';
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

bool get _isAndroid => !kIsWeb && Platform.isAndroid;

final sharedLinkBootstrapProvider = Provider<void>((ref) {
  if (!_isAndroid) {
    return;
  }
  final subscription = ReceiveSharingIntent.instance.getMediaStream().listen((
    files,
  ) {
    final link = sharedText(files);
    if (link != null) {
      ref.read(pendingLinkProvider.notifier).setLink(link);
    }
  });
  ref.onDispose(subscription.cancel);
  ReceiveSharingIntent.instance.getInitialMedia().then((files) async {
    final link = sharedText(files);
    if (link != null) {
      ref.read(pendingLinkProvider.notifier).setLink(link);
    }
    await ReceiveSharingIntent.instance.reset();
  });
});

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

Future<void> signInWithGoogle() async {
  final UserCredential credential;
  if (_isAndroid) {
    final account = await GoogleSignIn.instance.authenticate();
    final google = GoogleAuthProvider.credential(
      idToken: account.authentication.idToken,
    );
    credential = await FirebaseAuth.instance.signInWithCredential(google);
  } else {
    credential = await FirebaseAuth.instance.signInWithProvider(
      GoogleAuthProvider(),
    );
  }
  final user = credential.user;
  final email = user?.email;
  if (user != null && email != null) {
    await UserStore(FirebaseFirestore.instance, user.uid).ensureDirectory(
      email: email,
      displayName: user.displayName ?? email,
    );
  }
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  if (_isAndroid) {
    await GoogleSignIn.instance.signOut();
  }
}
