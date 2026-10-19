import 'dart:convert';

/// Which installable the running app should compare.
enum UpdatePlatform { android, windows, other }

class UpdateArtifact {
  const UpdateArtifact({
    required this.version,
    required this.build,
    required this.commit,
    required this.date,
    required this.notes,
    required this.url,
    required this.sha256,
  });

  final String version;
  final int build;
  final String commit;
  final String date;
  final String notes;
  final String url;
  final String sha256;
}

class UpdateManifest {
  const UpdateManifest({
    required this.version,
    required this.android,
    required this.windows,
  });

  final String version;
  final UpdateArtifact? android;
  final UpdateArtifact? windows;

  UpdateArtifact? forPlatform(UpdatePlatform platform) {
    return switch (platform) {
      UpdatePlatform.android => android,
      UpdatePlatform.windows => windows,
      UpdatePlatform.other => null,
    };
  }
}

/// Installed build from [PackageInfo.buildNumber], including `1.0.0+12`.
int parseInstalledBuild(String raw) {
  final trimmed = raw.trim();
  final direct = int.tryParse(trimmed);
  if (direct != null) {
    return direct;
  }
  final plus = trimmed.split('+');
  if (plus.length > 1) {
    final build = int.tryParse(plus.last.trim());
    if (build != null) {
      return build;
    }
  }
  final dotted = trimmed.split('.');
  if (dotted.length >= 4) {
    final build = int.tryParse(dotted.last.trim());
    if (build != null) {
      return build;
    }
  }
  return 0;
}

final _sha256Pattern = RegExp(r'^[0-9a-fA-F]{64}$');

UpdateManifest parseUpdateManifest(String raw) {
  final decoded = jsonDecode(raw);
  if (decoded is! Map) {
    throw const FormatException('The update manifest is not an object.');
  }
  final version = decoded['version'];
  if (version is! String || version.trim().isEmpty) {
    throw const FormatException('The update manifest has no version.');
  }
  return UpdateManifest(
    version: version.trim(),
    android: _artifact(decoded['android'], version.trim()),
    windows: _artifact(decoded['windows'], version.trim()),
  );
}

UpdateArtifact? _artifact(Object? raw, String version) {
  if (raw == null) {
    return null;
  }
  if (raw is! Map) {
    throw const FormatException('A platform block is not an object.');
  }
  final build = raw['build'];
  final url = raw['url'];
  final sha = raw['sha256'];
  if (build is! int || url is! String || sha is! String) {
    throw const FormatException(
      'A platform block is missing build, url, or sha256.',
    );
  }
  if (url.trim().isEmpty || !_sha256Pattern.hasMatch(sha)) {
    throw const FormatException(
      'A platform block has an empty url or a bad sha256.',
    );
  }
  return UpdateArtifact(
    version: version,
    build: build,
    commit: raw['commit'] is String ? raw['commit'] as String : '',
    date: raw['date'] is String ? raw['date'] as String : '',
    notes: raw['notes'] is String ? raw['notes'] as String : '',
    url: url.trim(),
    sha256: sha.toLowerCase(),
  );
}

/// A newer build number is an update. The version name can stay at 1.0.0.
bool isNewerBuild({required int installed, required int available}) {
  return available > installed;
}

/// Automatic checks wait a day. A skipped build stays quiet until a newer one.
bool shouldOfferUpdate({
  required int installedBuild,
  required int availableBuild,
  required int? skippedBuild,
  required bool manual,
}) {
  if (!isNewerBuild(installed: installedBuild, available: availableBuild)) {
    return false;
  }
  if (!manual && skippedBuild == availableBuild) {
    return false;
  }
  return true;
}

bool shouldAutoCheck({required DateTime? lastCheck, required DateTime now}) {
  if (lastCheck == null) {
    return true;
  }
  return now.difference(lastCheck) >= const Duration(hours: 24);
}

/// Flags for the Inno Setup installer. `/SILENT` keeps a small progress window.
const windowsInstallerArguments = <String>[
  '/SILENT',
  '/SUPPRESSMSGBOXES',
  '/NORESTART',
];
