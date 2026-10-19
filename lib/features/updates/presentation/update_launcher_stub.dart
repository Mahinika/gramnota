import 'package:flutter/material.dart';

import 'update_dialogs.dart';

Future<void> promptForUpdate(
  BuildContext context, {
  required bool manual,
}) async {
  if (!manual || !context.mounted) {
    return;
  }
  await showUpdateMessage(
    context,
    'Uppdateringar finns för Android och Windows.',
  );
}
