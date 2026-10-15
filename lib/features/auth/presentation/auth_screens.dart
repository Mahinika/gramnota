import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../firebase_options.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PrintPrice setup')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Firebase is not configured yet. Create a Firebase project, enable '
          'Google sign-in and Firestore, then run flutterfire configure. '
          'Add the debug SHA-1 for the Android app and deploy firestore.rules. '
          'The steps are in the README.',
        ),
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

  Future<void> _signIn() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await signInWithGoogle();
    } on Object catch (error) {
      setState(() => _error = '$error');
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PrintPrice',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Price your 3D prints on your phone or on this computer.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (!firebaseIsConfigured)
                  const Text('Firebase is not configured. See the README.'),
                if (_error != null) ...[
                  Text(_error!, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                ],
                FilledButton(
                  onPressed: _busy || !firebaseIsConfigured ? null : _signIn,
                  child: Text(_busy ? 'Signing in…' : 'Sign in with Google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
