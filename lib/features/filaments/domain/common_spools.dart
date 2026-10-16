/// Typical 1 kg spools for quick stock setup. Prices are indicative SEK shop
/// prices in minor units; adjust after adding.
class CommonSpool {
  const CommonSpool({
    required this.brand,
    required this.material,
    required this.colorLabel,
    required this.colorHex,
    this.spoolWeightGrams = 1000,
    this.pricePerSpoolMinor = 0,
  });

  final String brand;
  final String material;
  final String colorLabel;
  final String colorHex;
  final double spoolWeightGrams;
  final int pricePerSpoolMinor;

  String get label => '$brand $material · $colorLabel';
}

const commonSpools = <CommonSpool>[
  CommonSpool(
    brand: 'Bambu Lab',
    material: 'PLA Basic',
    colorLabel: 'Black',
    colorHex: '#1A1A1A',
    pricePerSpoolMinor: 24900,
  ),
  CommonSpool(
    brand: 'Bambu Lab',
    material: 'PLA Basic',
    colorLabel: 'White',
    colorHex: '#F5F5F5',
    pricePerSpoolMinor: 24900,
  ),
  CommonSpool(
    brand: 'Bambu Lab',
    material: 'PLA Basic',
    colorLabel: 'Gray',
    colorHex: '#9E9E9E',
    pricePerSpoolMinor: 24900,
  ),
  CommonSpool(
    brand: 'Bambu Lab',
    material: 'PETG Basic',
    colorLabel: 'Black',
    colorHex: '#1A1A1A',
    pricePerSpoolMinor: 27900,
  ),
  CommonSpool(
    brand: 'Prusament',
    material: 'PLA',
    colorLabel: 'Galaxy Black',
    colorHex: '#2B2B2B',
    pricePerSpoolMinor: 32900,
  ),
  CommonSpool(
    brand: 'eSUN',
    material: 'PLA+',
    colorLabel: 'Black',
    colorHex: '#1A1A1A',
    pricePerSpoolMinor: 19900,
  ),
  CommonSpool(
    brand: 'Polymaker',
    material: 'PolyLite PLA',
    colorLabel: 'Black',
    colorHex: '#1A1A1A',
    pricePerSpoolMinor: 22900,
  ),
  CommonSpool(
    brand: 'Generic',
    material: 'PLA',
    colorLabel: 'Unspecified',
    colorHex: '#808080',
    pricePerSpoolMinor: 0,
  ),
];

List<CommonSpool> matchingCommonSpools(String query) {
  final needle = query.trim().toLowerCase();
  if (needle.isEmpty) {
    return commonSpools;
  }
  return [
    for (final spool in commonSpools)
      if (spool.label.toLowerCase().contains(needle) ||
          spool.material.toLowerCase().contains(needle) ||
          spool.brand.toLowerCase().contains(needle))
        spool,
  ];
}
