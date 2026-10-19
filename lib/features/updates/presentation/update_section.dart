import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../domain/update_models.dart';
import 'update_launcher.dart';

class UpdateSection extends StatefulWidget {
  const UpdateSection({this.versionLabel, super.key});

  /// Set in tests so the widget does not read the device package info.
  final String? versionLabel;

  @override
  State<UpdateSection> createState() => _UpdateSectionState();
}

class _UpdateSectionState extends State<UpdateSection> {
  String _label = 'Version';
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
    setState(() => _checking = true);
    try {
      await promptForUpdate(context, manual: true);
    } finally {
      if (mounted) {
        setState(() => _checking = false);
      }
    }
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
          onPressed: _checking ? null : _search,
          child: Text(_checking ? 'Söker…' : 'Sök efter uppdateringar'),
        ),
      ],
    );
  }
}
