import 'package:flutter/material.dart';
import 'package:gramnota/l10n/l10n.dart';

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
  final message = context.l10n.updatePlatformsOnly;
  await showUpdateMessage(context, message);
  return UpdatePromptResult(message: message);
}
