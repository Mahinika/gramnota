import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../domain/gcode_metadata.dart';

class PlateImportChoice {
  const PlateImportChoice.all() : plate = null;

  const PlateImportChoice.single(this.plate);

  final GcodePlate? plate;

  bool get importAll => plate == null;
}

/// Asks whether a multi-plate file becomes several prints or one plate.
Future<PlateImportChoice?> showPlateImportDialog(
  BuildContext context,
  List<GcodePlate> plates,
) {
  return showDialog<PlateImportChoice>(
    context: context,
    builder: (context) {
      final l10n = context.l10n;
      return AlertDialog(
        title: Text(
          l10n.plateCountTitle(plates.length),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.plateImportHelp),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () =>
                    Navigator.pop(context, const PlateImportChoice.all()),
                child: Text(
                  l10n.plateImportAll(plates.length),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              for (final plate in plates)
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, PlateImportChoice.single(plate)),
                  child: Text(
                    plate.name.trim().isEmpty
                        ? l10n.plateDefaultName
                        : plate.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionCancel),
          ),
        ],
      );
    },
  );
}
