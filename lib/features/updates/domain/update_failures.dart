class UpdateNetworkException implements Exception {
  const UpdateNetworkException();
}

class UpdateDownloadException implements Exception {
  const UpdateDownloadException();
}

class UpdateChecksumException implements Exception {
  const UpdateChecksumException();
}

class UpdateManifestException implements Exception {
  const UpdateManifestException();
}

class UpdateInstallException implements Exception {
  const UpdateInstallException();
}

String updateFailureMessage(Object error) {
  if (error is UpdateChecksumException) {
    return 'Filen stämde inte (kontrollsumma). Inget installerades.';
  }
  if (error is UpdateDownloadException) {
    return 'Nedladdningen misslyckades.';
  }
  if (error is UpdateManifestException) {
    return 'Kunde inte läsa uppdateringsinformationen.';
  }
  if (error is UpdateNetworkException) {
    return 'Ingen internetanslutning. Försök igen senare.';
  }
  if (error is UpdateInstallException) {
    return 'Kunde inte starta installationen.';
  }
  if (error is FormatException) {
    return 'Kunde inte läsa uppdateringsinformationen.';
  }
  return 'Kunde inte söka efter uppdateringar.';
}
