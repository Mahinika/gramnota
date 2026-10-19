import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/firebase_emulator.dart';
import '../../../core/gate_scaffold.dart';
import '../../../core/providers.dart';
import '../../../firebase_options.dart';
import '../domain/sign_in_failed.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GateScaffold(
      title: 'Gramnota',
      subtitle: 'Setup',
      child: Text(
        'Firebase is not configured yet. Create a Firebase project, enable '
        'Google sign-in and Firestore, then run flutterfire configure. '
        'Add the debug SHA-1 for the Android app and deploy firestore.rules. '
        'The steps are in the README.',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  var _busy = false;
  String? _error;

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } on FirebaseAuthException catch (error) {
      setState(() {
        _error = error.message ?? 'Sign-in failed. Try again.';
      });
    } on SignInFailed catch (error) {
      setState(() => _error = error.message);
    } on Object {
      setState(() => _error = 'Sign-in failed. Try again.');
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GateScaffold(
      title: 'Gramnota',
      subtitle: 'Price your 3D prints on your phone or on this computer.',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!firebaseIsConfigured)
            const Text('Firebase is not configured. See the README.'),
          if (_error != null) ...[
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 12),
          ],
          if (kIsWeb)
            Text(
              useFirebaseEmulator
                  ? 'Google sign-in is not available in this browser. Use the test seller account.'
                  : 'Google sign-in is not available in this browser. Use the Android or Windows app.',
              textAlign: TextAlign.center,
            )
          else
            FilledButton(
              onPressed: _busy || !firebaseIsConfigured
                  ? null
                  : () => _run(signInWithGoogle),
              child: Text(_busy ? 'Signing in…' : 'Sign in with Google'),
            ),
          if (_busy &&
              !kIsWeb &&
              defaultTargetPlatform == TargetPlatform.windows) ...[
            const SizedBox(height: 12),
            const Text(
              'Finish sign-in in the browser, then return here.',
              textAlign: TextAlign.center,
            ),
          ],
          if (useFirebaseEmulator) ...[
            const SizedBox(height: 12),
            if (kIsWeb)
              FilledButton(
                onPressed: _busy || !firebaseIsConfigured
                    ? null
                    : () => _run(signInWithEmulatorTester),
                child: const Text('Sign in as test seller'),
              )
            else
              OutlinedButton(
                onPressed: _busy || !firebaseIsConfigured
                    ? null
                    : () => _run(signInWithEmulatorTester),
                child: const Text('Sign in as test seller'),
              ),
            const SizedBox(height: 8),
            Text(
              'Local Firebase emulators. This account is $emulatorTesterEmail.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}
