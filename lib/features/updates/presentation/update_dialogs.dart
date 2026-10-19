import 'package:flutter/material.dart';
import 'package:gramnota/l10n/l10n.dart';

import '../domain/update_models.dart';

enum UpdateChoice { update, later, skip }

class UpdateOfferDialog extends StatelessWidget {
  const UpdateOfferDialog({required this.artifact, super.key});

  final UpdateArtifact artifact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final notes = artifact.notes.trim();
    return AlertDialog(
      title: Text(l10n.updateAvailableTitle(artifact.version)),
      content: Text(notes.isEmpty ? l10n.updateBuildOnly(artifact.build) : notes),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, UpdateChoice.skip),
          child: Text(l10n.updateSkipVersion),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, UpdateChoice.later),
          child: Text(l10n.updateLater),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, UpdateChoice.update),
          child: Text(l10n.updateNow),
        ),
      ],
    );
  }
}

Future<void> showUpdateMessage(BuildContext context, String message) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(message),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.actionClose),
        ),
      ],
    ),
  );
}

Future<bool> showInstallPermissionDialog(BuildContext context) async {
  final open = await showDialog<bool>(
    context: context,
    builder: (context) {
      final l10n = context.l10n;
      return AlertDialog(
        title: Text(l10n.updateAllowInstallTitle),
        content: Text(l10n.updateAllowInstallBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionClose),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.updateOpenSettings),
          ),
        ],
      );
    },
  );
  return open ?? false;
}

Future<void> showAndroidConfirmHint(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      final l10n = context.l10n;
      return AlertDialog(
        title: Text(l10n.updateConfirmAndroidTitle),
        content: Text(l10n.updateConfirmAndroidBody),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionContinue),
          ),
        ],
      );
    },
  );
}

class UpdateCheckDialog extends StatelessWidget {
  const UpdateCheckDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(context.l10n.updateSearching)),
        ],
      ),
    );
  }
}

class UpdateProgressDialog extends StatelessWidget {
  const UpdateProgressDialog({required this.progress, super.key});

  final double? progress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.updateDownloading),
      content: LinearProgressIndicator(value: progress),
    );
  }
}
