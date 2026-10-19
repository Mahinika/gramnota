import 'package:flutter/material.dart';

import '../domain/update_models.dart';

enum UpdateChoice { update, later, skip }

class UpdateOfferDialog extends StatelessWidget {
  const UpdateOfferDialog({required this.artifact, super.key});

  final UpdateArtifact artifact;

  @override
  Widget build(BuildContext context) {
    final notes = artifact.notes.trim();
    return AlertDialog(
      title: Text('Ny version ${artifact.version} finns'),
      content: Text(
        notes.isEmpty
            ? 'Build ${artifact.build}.'
            : notes,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, UpdateChoice.skip),
          child: const Text('Hoppa över denna version'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, UpdateChoice.later),
          child: const Text('Senare'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, UpdateChoice.update),
          child: const Text('Uppdatera'),
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
          child: const Text('Stäng'),
        ),
      ],
    ),
  );
}

Future<bool> showInstallPermissionDialog(BuildContext context) async {
  final open = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Tillåt installation'),
      content: const Text(
        'Tillåt installation från Gramnota. Under Inställningar, välj '
        'Installera okända appar och slå på Gramnota. Tryck sedan Uppdatera igen.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Stäng'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Öppna inställningar'),
        ),
      ],
    ),
  );
  return open ?? false;
}

Future<void> showAndroidConfirmHint(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Bekräfta i Android'),
      content: const Text(
        'Android visar en egen ruta. Tryck Installera där. '
        'Den rutan går inte att hoppa över.',
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fortsätt'),
        ),
      ],
    ),
  );
}

class UpdateProgressDialog extends StatelessWidget {
  const UpdateProgressDialog({required this.progress, super.key});

  final double? progress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Laddar ner uppdateringen…'),
      content: LinearProgressIndicator(value: progress),
    );
  }
}
