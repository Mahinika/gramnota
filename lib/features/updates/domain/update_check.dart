import '../data/update_preferences.dart';
import 'update_failures.dart';
import 'update_models.dart';

/// Fetches the manifest. The HTTP client lives behind this so web builds
/// do not import `dart:io`.
abstract class ManifestSource {
  Future<UpdateManifest> fetchManifest();
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

  Future<UpdateCheckOutcome> check({required bool manual}) async {
    if (platform == UpdatePlatform.other) {
      if (!manual) {
        return const UpdateCheckOutcome();
      }
      return const UpdateCheckOutcome(
        message: 'Uppdateringar finns för Android och Windows.',
      );
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
    } on Object catch (error) {
      if (!manual) {
        return const UpdateCheckOutcome();
      }
      return UpdateCheckOutcome(message: updateFailureMessage(error));
    }
    await preferences.setLastCheck(_now());
    final artifact = manifest.forPlatform(platform);
    if (artifact == null) {
      if (!manual) {
        return const UpdateCheckOutcome();
      }
      return const UpdateCheckOutcome(
        message: 'Kunde inte läsa uppdateringsinformationen.',
      );
    }
    final skipped = await preferences.skippedBuild();
    if (!shouldOfferUpdate(
      installedBuild: installedBuild,
      availableBuild: artifact.build,
      skippedBuild: skipped,
      manual: manual,
    )) {
      if (!manual) {
        return const UpdateCheckOutcome();
      }
      return const UpdateCheckOutcome(
        upToDate: true,
        message: 'Du har redan den senaste versionen.',
      );
    }
    return UpdateCheckOutcome(artifact: artifact);
  }
}
