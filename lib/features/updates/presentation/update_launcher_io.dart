import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../data/update_client.dart';
import '../data/update_preferences.dart';
import '../domain/update_check.dart';
import '../domain/update_failures.dart';
import '../domain/update_models.dart';
import '../update_config.dart';
import 'update_dialogs.dart';

const updateMethodChannel = MethodChannel('se.gramnota.app/updates');

UpdatePlatform currentUpdatePlatform() {
  if (Platform.isAndroid) {
    return UpdatePlatform.android;
  }
  if (Platform.isWindows) {
    return UpdatePlatform.windows;
  }
  return UpdatePlatform.other;
}

Future<void> promptForUpdate(
  BuildContext context, {
  required bool manual,
  UpdateCoordinator? coordinator,
  UpdateClient? client,
}) async {
  final info = await PackageInfo.fromPlatform();
  final installed = parseInstalledBuild(info.buildNumber);
  final downloader = client ?? UpdateClient(manifestUrl: updateManifestUrl);
  final active =
      coordinator ??
      UpdateCoordinator(
        client: downloader,
        preferences: await SharedUpdatePreferences.load(),
        platform: currentUpdatePlatform(),
        installedBuild: installed,
      );
  final outcome = await active.check(manual: manual);
  if (!context.mounted) {
    return;
  }
  final artifact = outcome.artifact;
  if (artifact == null) {
    final message = outcome.message;
    if (manual && message != null) {
      await showUpdateMessage(context, message);
    }
    return;
  }
  final choice = await showDialog<UpdateChoice>(
    context: context,
    builder: (context) => UpdateOfferDialog(artifact: artifact),
  );
  if (choice == UpdateChoice.skip) {
    await active.preferences.setSkippedBuild(artifact.build);
    return;
  }
  if (choice != UpdateChoice.update || !context.mounted) {
    return;
  }
  await _downloadAndInstall(context, artifact, downloader);
}

Future<void> _downloadAndInstall(
  BuildContext context,
  UpdateArtifact artifact,
  UpdateClient client,
) async {
  final progress = ValueNotifier<double?>(0);
  Object? failure;
  File? downloaded;
  var started = false;
  var closed = false;
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      if (!started) {
        started = true;
        unawaited(() async {
          try {
            final directory = await getTemporaryDirectory();
            final name = currentUpdatePlatform() == UpdatePlatform.android
                ? 'Gramnota.apk'
                : 'Gramnota-Setup.exe';
            final destination = File('${directory.path}/updates/$name');
            await client.download(
              url: artifact.url,
              sha256: artifact.sha256,
              destination: destination,
              onProgress: (value) {
                if (!closed) {
                  progress.value = value;
                }
              },
            );
            downloaded = destination;
            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop();
            }
          } on Object catch (error) {
            failure = error;
            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop();
            }
          }
        }());
      }
      return ValueListenableBuilder<double?>(
        valueListenable: progress,
        builder: (context, value, _) => UpdateProgressDialog(progress: value),
      );
    },
  );
  closed = true;
  progress.dispose();
  if (!context.mounted) {
    return;
  }
  if (failure != null) {
    await showUpdateMessage(context, updateFailureMessage(failure!));
    return;
  }
  final file = downloaded;
  if (file == null) {
    return;
  }
  try {
    await _installDownloaded(context, file);
  } on Object catch (error) {
    if (context.mounted) {
      await showUpdateMessage(context, updateFailureMessage(error));
    }
  }
}

Future<void> _installDownloaded(BuildContext context, File file) async {
  if (Platform.isAndroid) {
    final allowed = await updateMethodChannel.invokeMethod<bool>(
      'canInstallPackages',
    );
    if (!context.mounted) {
      return;
    }
    if (allowed != true) {
      final open = await showInstallPermissionDialog(context);
      if (open) {
        await updateMethodChannel.invokeMethod<void>(
          'openInstallPermissionSettings',
        );
      }
      return;
    }
    await showAndroidConfirmHint(context);
    if (!context.mounted) {
      return;
    }
    await updateMethodChannel.invokeMethod<void>('installApk', {
      'path': file.path,
    });
    return;
  }
  if (Platform.isWindows) {
    await Process.start(
      file.path,
      windowsInstallerArguments,
      mode: ProcessStartMode.detached,
    );
    await Future<void>.delayed(const Duration(milliseconds: 400));
    exit(0);
  }
  throw const UpdateInstallException();
}
