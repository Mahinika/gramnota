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

String updateFailureMessage(Object error) {
  final summary = switch (error) {
    UpdateChecksumException() =>
      'Filen stämde inte (kontrollsumma). Inget installerades.',
    UpdateDownloadException() => 'Nedladdningen misslyckades.',
    UpdateManifestException() => 'Kunde inte läsa uppdateringsinformationen.',
    UpdateNetworkException() => 'Ingen internetanslutning. Försök igen senare.',
    UpdateInstallException() => 'Kunde inte starta installationen.',
    FormatException() => 'Kunde inte läsa uppdateringsinformationen.',
    _ => 'Kunde inte söka efter uppdateringar.',
  };
  final detail = updateFailureDetail(error);
  if (detail == null || detail.isEmpty) {
    return summary;
  }
  return '$summary ($detail)';
}
