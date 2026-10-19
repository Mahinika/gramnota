import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../domain/update_check.dart';
import '../domain/update_failures.dart';
import '../domain/update_models.dart';
import 'update_launcher.dart';

class UpdateSection extends StatefulWidget {
  const UpdateSection({this.versionLabel, this.prompt, super.key});

  /// Set in tests so the widget does not read the device package info.
  final String? versionLabel;

  /// Replaces [promptForUpdate] in tests.
  final Future<UpdatePromptResult> Function(BuildContext context)? prompt;

  @override
  State<UpdateSection> createState() => _UpdateSectionState();
}

class _UpdateSectionState extends State<UpdateSection> {
  String _label = 'Version';
  String? _message;
  var _busy = false;
  var _checking = false;

  @override
  void initState() {
    super.initState();
    final injected = widget.versionLabel;
    if (injected != null) {
      _label = injected;
      return;
    }
    _load();
  }

  Future<void> _load() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (!mounted) {
        return;
      }
      final version = info.version.trim().isEmpty
          ? '1.0.0'
          : info.version.trim();
      final build = parseInstalledBuild(info.buildNumber);
      setState(() => _label = 'Version $version (build $build)');
    } on Object {
      if (!mounted) {
        return;
      }
      setState(() => _label = 'Version');
    }
  }

  Future<void> _search() async {
    setState(() {
      _busy = true;
      _checking = true;
      _message = null;
    });
    try {
      final prompt = widget.prompt ?? _prompt;
      final result = await prompt(context);
      if (!mounted) {
        return;
      }
      setState(() => _message = result.message);
    } on Object catch (error, stackTrace) {
      log(
        'Update search failed',
        name: updateLogName,
        error: error,
        stackTrace: stackTrace,
      );
      if (!mounted) {
        return;
      }
      setState(() => _message = updateFailureMessage(error));
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _checking = false;
        });
      }
    }
  }

  Future<UpdatePromptResult> _prompt(BuildContext context) {
    return promptForUpdate(
      context,
      manual: true,
      onReady: () {
        if (mounted) {
          setState(() => _checking = false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(_label, style: theme.textTheme.bodyMedium),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: _busy ? null : _search,
          child: _checking
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('Söker…'),
                  ],
                )
              : const Text('Sök efter uppdateringar'),
        ),
        if (_message != null) ...[const SizedBox(height: 8), Text(_message!)],
      ],
    );
  }
}
