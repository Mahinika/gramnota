import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gramnota/l10n/l10n.dart';
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

Future<UpdatePromptResult> promptForUpdate(
  BuildContext context, {
  required bool manual,
  UpdateCoordinator? coordinator,
  UpdateClient? client,
  void Function()? onReady,
}) async {
  final l10n = context.mounted ? context.l10n : activeGramnotaL10n;
  final navigator = Navigator.maybeOf(context, rootNavigator: true);
  DialogRoute<void>? spinner;
  if (manual && navigator != null && context.mounted) {
    spinner = DialogRoute<void>(
      context: navigator.context,
      barrierDismissible: false,
      builder: (context) =>
          const PopScope(canPop: false, child: UpdateCheckDialog()),
    );
    unawaited(navigator.push(spinner));
  }

  Future<void> closeSpinner() async {
    final route = spinner;
    if (route == null) {
      return;
    }
    spinner = null;
    if (navigator != null && route.isActive) {
      navigator.removeRoute(route);
    }
  }

  try {
    final downloader = client ?? UpdateClient(manifestUrl: updateManifestUrl);
    final active =
        coordinator ??
        UpdateCoordinator(
          client: downloader,
          preferences: await _loadPreferences(),
          platform: currentUpdatePlatform(),
          installedBuild: await _readInstalledBuild(),
        );
    final outcome = await active.check(manual: manual, l10n: l10n);
    onReady?.call();
    await closeSpinner();
    final artifact = outcome.artifact;
    if (artifact == null) {
      final message = outcome.message;
      if (manual && message != null) {
        if (context.mounted) {
          await _present(context, navigator, message);
        } else if (navigator != null && navigator.mounted) {
          await _present(navigator.context, navigator, message);
        } else {
          log('Update result was not shown: $message', name: updateLogName);
        }
      }
      return UpdatePromptResult(message: manual ? message : null);
    }
    if (!context.mounted) {
      return _offerUpdate(
        host: _navigatorContext(navigator),
        navigator: navigator,
        artifact: artifact,
        preferences: active.preferences,
        downloader: downloader,
        l10n: l10n,
      );
    }
    return _offerUpdate(
      host: context,
      navigator: navigator,
      artifact: artifact,
      preferences: active.preferences,
      downloader: downloader,
      l10n: l10n,
    );
  } on Object catch (error, stackTrace) {
    onReady?.call();
    await closeSpinner();
    log(
      'Update prompt failed',
      name: updateLogName,
      error: error,
      stackTrace: stackTrace,
    );
    final message = updateFailureMessage(error, l10n);
    if (manual) {
      if (context.mounted) {
        await _present(context, navigator, message);
      } else if (navigator != null && navigator.mounted) {
        await _present(navigator.context, navigator, message);
      } else {
        log('Update result was not shown: $message', name: updateLogName);
      }
    }
    return UpdatePromptResult(message: manual ? message : null);
  }
}

Future<UpdatePromptResult> _offerUpdate({
  required BuildContext? host,
  required NavigatorState? navigator,
  required UpdateArtifact artifact,
  required UpdatePreferences preferences,
  required UpdateClient downloader,
  required AppLocalizations l10n,
}) async {
  if (host == null || !host.mounted) {
    log(
      'Update ${artifact.build} was found after the page closed',
      name: updateLogName,
    );
    return UpdatePromptResult(
      message: l10n.updateFoundWhileClosed(artifact.version, artifact.build),
    );
  }
  final choice = await showDialog<UpdateChoice>(
    context: host,
    useRootNavigator: true,
    builder: (context) => UpdateOfferDialog(artifact: artifact),
  );
  if (choice == UpdateChoice.skip) {
    await preferences.setSkippedBuild(artifact.build);
    return const UpdatePromptResult();
  }
  if (choice != UpdateChoice.update) {
    return const UpdatePromptResult();
  }
  final installHost = host.mounted ? host : _navigatorContext(navigator);
  if (installHost == null || !installHost.mounted) {
    return UpdatePromptResult(message: l10n.updateInstallFailed);
  }
  await _downloadAndInstall(installHost, artifact, downloader);
  return const UpdatePromptResult();
}

Future<int> _readInstalledBuild() async {
  Object? failure;
  StackTrace? failureStack;
  if (Platform.isAndroid) {
    try {
      final raw = await updateMethodChannel.invokeMethod<Object>(
        'installedBuild',
      );
      if (raw is int) {
        return raw;
      }
      if (raw is num) {
        return raw.toInt();
      }
    } on Object catch (error, stackTrace) {
      failure = error;
      failureStack = stackTrace;
      log(
        'Could not read the Android version code',
        name: updateLogName,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  try {
    final info = await PackageInfo.fromPlatform();
    return parseInstalledBuild(info.buildNumber);
  } on Object catch (error, stackTrace) {
    log(
      'Could not read the package build number',
      name: updateLogName,
      error: error,
      stackTrace: stackTrace,
    );
    failure = error;
    failureStack = stackTrace;
  }
  Error.throwWithStackTrace(failure, failureStack);
}

Future<UpdatePreferences> _loadPreferences() async {
  try {
    return await SharedUpdatePreferences.load();
  } on Object catch (error, stackTrace) {
    log(
      'Update preferences are unavailable',
      name: updateLogName,
      error: error,
      stackTrace: stackTrace,
    );
    return MemoryUpdatePreferences();
  }
}

BuildContext? _navigatorContext(NavigatorState? navigator) {
  if (navigator != null && navigator.mounted) {
    return navigator.context;
  }
  return null;
}

Future<void> _present(
  BuildContext context,
  NavigatorState? navigator,
  String message,
) async {
  final host = context.mounted ? context : _navigatorContext(navigator);
  if (host == null || !host.mounted) {
    log('Update result was not shown: $message', name: updateLogName);
    return;
  }
  try {
    await showUpdateMessage(host, message);
  } on Object catch (error, stackTrace) {
    log(
      'Could not show the update message',
      name: updateLogName,
      error: error,
      stackTrace: stackTrace,
    );
  }
}

Future<void> _downloadAndInstall(
  BuildContext context,
  UpdateArtifact artifact,
  UpdateClient client,
) async {
  final l10n = context.l10n;
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
    await showUpdateMessage(context, updateFailureMessage(failure!, l10n));
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
      await showUpdateMessage(context, updateFailureMessage(error, l10n));
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
