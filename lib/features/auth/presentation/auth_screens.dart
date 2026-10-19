import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gramnota/l10n/l10n.dart';

import '../../../core/firebase_emulator.dart';
import '../../../core/gate_scaffold.dart';
import '../../../core/providers.dart';
import '../../../firebase_options.dart';
import '../domain/sign_in_failed.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return GateScaffold(
      title: l10n.appTitle,
      subtitle: l10n.authSetupSubtitle,
      child: Text(l10n.authSetupBody, textAlign: TextAlign.center),
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
    final failed = context.l10n.authSignInFailed;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } on FirebaseAuthException catch (error) {
      setState(() {
        _error = error.message ?? failed;
      });
    } on SignInFailed catch (error) {
      setState(() => _error = error.message);
    } on Object {
      setState(() => _error = failed);
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return GateScaffold(
      title: l10n.appTitle,
      subtitle: l10n.authSignInSubtitle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!firebaseIsConfigured) Text(l10n.authFirebaseMissing),
          if (_error != null) ...[
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 12),
          ],
          if (kIsWeb)
            Text(
              useFirebaseEmulator ? l10n.authWebEmulator : l10n.authWebUseApp,
              textAlign: TextAlign.center,
            )
          else
            FilledButton(
              onPressed: _busy || !firebaseIsConfigured
                  ? null
                  : () => _run(signInWithGoogle),
              child: Text(_busy ? l10n.authSigningIn : l10n.authSignInGoogle),
            ),
          if (_busy &&
              !kIsWeb &&
              defaultTargetPlatform == TargetPlatform.windows) ...[
            const SizedBox(height: 12),
            Text(l10n.authFinishInBrowser, textAlign: TextAlign.center),
          ],
          if (useFirebaseEmulator) ...[
            const SizedBox(height: 12),
            if (kIsWeb)
              FilledButton(
                onPressed: _busy || !firebaseIsConfigured
                    ? null
                    : () => _run(signInWithEmulatorTester),
                child: Text(l10n.authSignInTestSeller),
              )
            else
              OutlinedButton(
                onPressed: _busy || !firebaseIsConfigured
                    ? null
                    : () => _run(signInWithEmulatorTester),
                child: Text(l10n.authSignInTestSeller),
              ),
            const SizedBox(height: 8),
            Text(
              l10n.authEmulatorAccount(emulatorTesterEmail),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}
