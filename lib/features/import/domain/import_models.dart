class ImportedFilament {
  const ImportedFilament({
    required this.grams,
    this.material = '',
    this.colorHex = '',
  });

  final double grams;
  final String material;
  final String colorHex;
}

class PrinterVariant {
  const PrinterVariant({
    required this.printerName,
    required this.printTimeSeconds,
    required this.filaments,
  });

  final String printerName;
  final int printTimeSeconds;
  final List<ImportedFilament> filaments;
}

class ImportedProfile {
  const ImportedProfile({
    required this.id,
    required this.title,
    required this.printTimeSeconds,
    required this.filaments,
    this.printerName = '',
    this.variants = const [],
  });

  final String id;
  final String title;
  final int? printTimeSeconds;
  final String printerName;
  final List<ImportedFilament> filaments;
  final List<PrinterVariant> variants;
}

class ImportResult {
  const ImportResult({
    required this.title,
    required this.sourceUrl,
    required this.profiles,
    this.missing = const [],
    this.note = '',
  });

  final String title;
  final String sourceUrl;
  final List<ImportedProfile> profiles;
  final List<String> missing;
  final String note;

  bool get hasPricingData =>
      profiles.any(
        (profile) =>
            profile.printTimeSeconds != null && profile.filaments.isNotEmpty,
      );
}

abstract class TextFetcher {
  Future<String> get(Uri uri);
  Future<String> postJson(Uri uri, Map<String, Object?> body);
}

/// Drops site chrome from a page title.
///
/// Thingiverse repeats the author (`by Name.se by Name`). Creality appends
/// `STL & 3MF File for 3D Printing` and a `| Creality Cloud` suffix.
String cleanModelTitle(String raw) {
  var title = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
  title = title.split(RegExp(r'\s+\|\s+')).first.trim();
  title = title
      .replaceAll(
        RegExp(
          r'\s+STL\s*&\s*3MF(?:\s+File)?(?:\s+for\s+3D\s+Printing)?\s*$',
          caseSensitive: false,
        ),
        '',
      )
      .trim();
  final repeated = RegExp(r'^(.*) by (.+) by ([^|]+)$').firstMatch(title);
  if (repeated != null) {
    final earlier = repeated.group(2)!.trim().toLowerCase();
    final last = repeated.group(3)!.trim().toLowerCase();
    final earlierStem = earlier.split('.').first;
    final lastStem = last.split('.').first;
    if (earlierStem == lastStem ||
        earlier.startsWith(last) ||
        last.startsWith(earlier)) {
      title = '${repeated.group(1)!.trim()} by ${repeated.group(2)!.trim()}';
    }
  }
  return title.trim();
}
