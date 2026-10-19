import 'package:gramnota/l10n/l10n.dart';

const updateLogName = 'gramnota.updates';

class UpdateNetworkException implements Exception {
  const UpdateNetworkException([this.detail]);

  final String? detail;

  @override
  String toString() => _describe('UpdateNetworkException', detail);
}

class UpdateDownloadException implements Exception {
  const UpdateDownloadException([this.detail]);

  final String? detail;

  @override
  String toString() => _describe('UpdateDownloadException', detail);
}

class UpdateChecksumException implements Exception {
  const UpdateChecksumException();

  @override
  String toString() => 'UpdateChecksumException';
}

class UpdateManifestException implements Exception {
  const UpdateManifestException([this.detail]);

  final String? detail;

  @override
  String toString() => _describe('UpdateManifestException', detail);
}

class UpdateInstallException implements Exception {
  const UpdateInstallException([this.detail]);

  final String? detail;

  @override
  String toString() => _describe('UpdateInstallException', detail);
}

String _describe(String name, String? detail) {
  if (detail == null || detail.isEmpty) {
    return name;
  }
  return '$name: $detail';
}

String? updateFailureDetail(Object error) {
  return switch (error) {
    UpdateNetworkException(:final detail) => detail,
    UpdateDownloadException(:final detail) => detail,
    UpdateManifestException(:final detail) => detail,
    UpdateInstallException(:final detail) => detail,
    UpdateChecksumException() => null,
    FormatException(:final message) => message.isEmpty ? null : message,
    _ => '$error',
  };
}

String updateFailureMessage(Object error, AppLocalizations l10n) {
  final summary = switch (error) {
    UpdateChecksumException() => l10n.updateChecksumFailed,
    UpdateDownloadException() => l10n.updateDownloadFailed,
    UpdateManifestException() => l10n.updateManifestUnreadable,
    UpdateNetworkException() => l10n.updateNoConnection,
    UpdateInstallException() => l10n.updateInstallFailed,
    FormatException() => l10n.updateManifestUnreadable,
    _ => l10n.updateSearchFailed,
  };
  final detail = updateFailureDetail(error);
  if (detail == null || detail.isEmpty) {
    return summary;
  }
  return '$summary ($detail)';
}
