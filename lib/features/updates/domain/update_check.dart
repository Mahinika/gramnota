import 'dart:developer';

import 'package:gramnota/l10n/l10n.dart';

import '../data/update_preferences.dart';
import 'update_failures.dart';
import 'update_models.dart';

/// Fetches the manifest. The HTTP client lives behind this so web builds
/// do not import `dart:io`.
abstract class ManifestSource {
  Future<UpdateManifest> fetchManifest();
}

/// What a manual check should tell the user, besides an update dialog.
class UpdatePromptResult {
  const UpdatePromptResult({this.message});

  final String? message;
}

class UpdateCheckOutcome {
  const UpdateCheckOutcome({
    this.artifact,
    this.message,
    this.upToDate = false,
  });

  final UpdateArtifact? artifact;
  final String? message;
  final bool upToDate;

  bool get hasUpdate => artifact != null;
}

class UpdateCoordinator {
  UpdateCoordinator({
    required this.client,
    required this.preferences,
    required this.platform,
    required this.installedBuild,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final ManifestSource client;
  final UpdatePreferences preferences;
  final UpdatePlatform platform;
  final int installedBuild;
  final DateTime Function() _now;

  Future<UpdateCheckOutcome> check({
    required bool manual,
    required AppLocalizations l10n,
  }) async {
    if (platform == UpdatePlatform.other) {
      if (!manual) {
        return const UpdateCheckOutcome();
      }
      return UpdateCheckOutcome(message: l10n.updatePlatformsOnly);
    }
    if (!manual) {
      final last = await preferences.lastCheck();
      if (!shouldAutoCheck(lastCheck: last, now: _now())) {
        return const UpdateCheckOutcome();
      }
    }
    final UpdateManifest manifest;
    try {
      manifest = await client.fetchManifest();
    } on Object catch (error, stackTrace) {
      log(
        'Update check failed',
        name: updateLogName,
        error: error,
        stackTrace: stackTrace,
      );
      if (!manual) {
        return const UpdateCheckOutcome();
      }
      return UpdateCheckOutcome(message: updateFailureMessage(error, l10n));
    }
    try {
      await preferences.setLastCheck(_now());
    } on Object catch (error, stackTrace) {
      log(
        'Could not store the update check time',
        name: updateLogName,
        error: error,
        stackTrace: stackTrace,
      );
    }
    final artifact = manifest.forPlatform(platform);
    if (artifact == null) {
      if (!manual) {
        return const UpdateCheckOutcome();
      }
      return UpdateCheckOutcome(message: l10n.updateManifestUnreadable);
    }
    int? skipped;
    try {
      skipped = await preferences.skippedBuild();
    } on Object catch (error, stackTrace) {
      log(
        'Could not read the skipped update',
        name: updateLogName,
        error: error,
        stackTrace: stackTrace,
      );
    }
    if (!shouldOfferUpdate(
      installedBuild: installedBuild,
      availableBuild: artifact.build,
      skippedBuild: skipped,
      manual: manual,
    )) {
      if (!manual) {
        return const UpdateCheckOutcome();
      }
      return UpdateCheckOutcome(
        upToDate: true,
        message: l10n.updateAlreadyLatestBuild(installedBuild),
      );
    }
    return UpdateCheckOutcome(artifact: artifact);
  }
}
