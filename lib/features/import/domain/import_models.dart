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
