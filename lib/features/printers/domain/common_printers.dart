/// Starting values for a new printer.
///
/// Power is the average while printing PLA, from the maker when they publish
/// one. Prices are SEK including VAT in October 2026. Lifetime is 5,000 hours
/// because the makers do not publish a service life. Maintenance stays 0;
/// machine wear in a quote is the purchase price divided by the lifetime.
class CommonPrinter {
  const CommonPrinter({
    required this.name,
    required this.powerWatts,
    required this.purchasePriceMinor,
  });

  final String name;
  final int powerWatts;
  final int purchasePriceMinor;

  static const lifetimeHours = 5000.0;

  int get purchasePriceKronor => purchasePriceMinor ~/ 100;
}

const commonPrinters = <CommonPrinter>[
  // Bambu Lab wiki, PLA average power. 3DJake / Prisjakt, October 2026.
  CommonPrinter(
    name: 'Bambu Lab A1 mini',
    powerWatts: 80,
    purchasePriceMinor: 249500,
  ),
  CommonPrinter(
    name: 'Bambu Lab A1',
    powerWatts: 95,
    purchasePriceMinor: 314500,
  ),
  CommonPrinter(
    name: 'Bambu Lab P1S',
    powerWatts: 105,
    purchasePriceMinor: 460300,
  ),
  CommonPrinter(
    name: 'Bambu Lab P2S',
    powerWatts: 200,
    purchasePriceMinor: 639500,
  ),
  // Prusa product pages: MK4S 80 W, CORE One+ 90 W.
  // Assembled EUR prices times the ECB rate 11.1765 on 15 October 2026.
  CommonPrinter(
    name: 'Prusa MK4S',
    powerWatts: 80,
    purchasePriceMinor: 1116500,
  ),
  CommonPrinter(
    name: 'Prusa CORE One+',
    powerWatts: 90,
    purchasePriceMinor: 1507700,
  ),
  // 120 W is a measured PLA average, not Creality's power-supply rating.
  // 3DJake price, October 2026.
  CommonPrinter(
    name: 'Creality Ender-3 V3 SE',
    powerWatts: 120,
    purchasePriceMinor: 195200,
  ),
];
