import 'package:flutter/material.dart';

import '../domain/update_check.dart';
import 'update_dialogs.dart';

Future<UpdatePromptResult> promptForUpdate(
  BuildContext context, {
  required bool manual,
  // Matches the IO implementation. Web has no manifest client.
  // ignore: avoid_unused_constructor_parameters
  UpdateCoordinator? coordinator,
  void Function()? onReady,
}) async {
  onReady?.call();
  if (!manual || !context.mounted) {
    return const UpdatePromptResult();
  }
  const message = 'Uppdateringar finns för Android och Windows.';
  await showUpdateMessage(context, message);
  return const UpdatePromptResult(message: message);
}
