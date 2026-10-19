import 'package:flutter/material.dart';

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
      return AlertDialog(
        title: Text(
          plates.length == 1 ? '1 plate' : '${plates.length} plates',
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Import all plates as separate prints on the quote, or fill this form from one plate.',
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => Navigator.pop(context, const PlateImportChoice.all()),
                child: Text('Import all ${plates.length} plates'),
              ),
              const SizedBox(height: 8),
              for (final plate in plates)
                TextButton(
                  onPressed: () => Navigator.pop(
                    context,
                    PlateImportChoice.single(plate),
                  ),
                  child: Text(
                    plate.name.trim().isEmpty ? 'Plate' : plate.name,
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
