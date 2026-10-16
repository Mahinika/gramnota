/// Starting values for a new printer.
///
/// The first printers use a maker PLA average and a Swedish shop price from
/// October 2026. The hundred after them come from the open 3D printer
/// database: the euro retail price times the ECB rate 11.1765 on 15 October
/// 2026, and power at 31 percent of the listed heater wattage, because that
/// catalog records the power supply rather than the average while printing.
/// Lifetime is 5,000 hours because makers do not publish a service life.
/// Maintenance stays 0; machine wear in a quote is the purchase price divided
/// by the lifetime.
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
  // Open 3D printer database, heater wattage times 0.31, EUR times 11.1765.
  CommonPrinter(
    name: 'Bambu Lab A1 Combo',
    powerWatts: 93,
    purchasePriceMinor: 378900,
  ),
  CommonPrinter(
    name: 'Bambu Lab A1 Mini Combo',
    powerWatts: 62,
    purchasePriceMinor: 445900,
  ),
  CommonPrinter(
    name: 'Bambu Lab A2',
    powerWatts: 87,
    purchasePriceMinor: 278300,
  ),
  CommonPrinter(
    name: 'Bambu Lab A2 Combo',
    powerWatts: 87,
    purchasePriceMinor: 390100,
  ),
  CommonPrinter(
    name: 'Bambu Lab H2C',
    powerWatts: 310,
    purchasePriceMinor: 2681200,
  ),
  CommonPrinter(
    name: 'Bambu Lab H2D',
    powerWatts: 124,
    purchasePriceMinor: 2793000,
  ),
  CommonPrinter(
    name: 'Bambu Lab H2S',
    powerWatts: 310,
    purchasePriceMinor: 1395900,
  ),
  CommonPrinter(
    name: 'Bambu Lab P1P',
    powerWatts: 93,
    purchasePriceMinor: 613600,
  ),
  CommonPrinter(
    name: 'Bambu Lab P1S Combo',
    powerWatts: 108,
    purchasePriceMinor: 1172400,
  ),
  CommonPrinter(
    name: 'Bambu Lab P2S Combo',
    powerWatts: 108,
    purchasePriceMinor: 1004800,
  ),
  CommonPrinter(
    name: 'Bambu Lab X1',
    powerWatts: 108,
    purchasePriceMinor: 1228300,
  ),
  CommonPrinter(
    name: 'Bambu Lab X1 Carbon',
    powerWatts: 108,
    purchasePriceMinor: 1340100,
  ),
  CommonPrinter(
    name: 'Bambu Lab X1E',
    powerWatts: 124,
    purchasePriceMinor: 2010700,
  ),
  CommonPrinter(
    name: 'Bambu Lab X2D',
    powerWatts: 248,
    purchasePriceMinor: 703000,
  ),
  CommonPrinter(
    name: 'Prusa Core One',
    powerWatts: 108,
    purchasePriceMinor: 893000,
  ),
  CommonPrinter(
    name: 'Prusa Mini+',
    powerWatts: 40,
    purchasePriceMinor: 479500,
  ),
  CommonPrinter(
    name: 'Prusa MK3S+',
    powerWatts: 56,
    purchasePriceMinor: 893000,
  ),
  CommonPrinter(name: 'Prusa MK4', powerWatts: 81, purchasePriceMinor: 781200),
  CommonPrinter(name: 'Prusa XL', powerWatts: 140, purchasePriceMinor: 2234200),
  CommonPrinter(
    name: 'Creality CR-10',
    powerWatts: 93,
    purchasePriceMinor: 447100,
  ),
  CommonPrinter(
    name: 'Creality Ender 3',
    powerWatts: 62,
    purchasePriceMinor: 200100,
  ),
  CommonPrinter(
    name: 'Creality Ender 3 Hi',
    powerWatts: 78,
    purchasePriceMinor: 413500,
  ),
  CommonPrinter(
    name: 'Creality Ender 3 V2',
    powerWatts: 62,
    purchasePriceMinor: 244800,
  ),
  CommonPrinter(
    name: 'Creality Ender 3 V3',
    powerWatts: 78,
    purchasePriceMinor: 323000,
  ),
  CommonPrinter(
    name: 'Creality Ender 3 V3 KE',
    powerWatts: 68,
    purchasePriceMinor: 334200,
  ),
  CommonPrinter(
    name: 'Creality Ender 3 V3 Plus',
    powerWatts: 93,
    purchasePriceMinor: 445900,
  ),
  CommonPrinter(
    name: 'Creality Ender 5',
    powerWatts: 78,
    purchasePriceMinor: 335300,
  ),
  CommonPrinter(
    name: 'Creality Ender 5 Max',
    powerWatts: 108,
    purchasePriceMinor: 781200,
  ),
  CommonPrinter(
    name: 'Creality Ender 5 Pro',
    powerWatts: 78,
    purchasePriceMinor: 391200,
  ),
  CommonPrinter(
    name: 'Creality Ender 5 S1',
    powerWatts: 87,
    purchasePriceMinor: 502900,
  ),
  CommonPrinter(
    name: 'Creality Ender 6',
    powerWatts: 93,
    purchasePriceMinor: 558800,
  ),
  CommonPrinter(
    name: 'Creality Ender-3 Max Neo',
    powerWatts: 78,
    purchasePriceMinor: 391200,
  ),
  CommonPrinter(
    name: 'Creality Ender-3 V3 Core',
    powerWatts: 62,
    purchasePriceMinor: 222400,
  ),
  CommonPrinter(
    name: 'Creality K2',
    powerWatts: 108,
    purchasePriceMinor: 614700,
  ),
  CommonPrinter(
    name: 'Creality K2 Plus',
    powerWatts: 124,
    purchasePriceMinor: 1116500,
  ),
  CommonPrinter(
    name: 'Creality K2 Pro',
    powerWatts: 124,
    purchasePriceMinor: 838200,
  ),
  CommonPrinter(
    name: 'Creality K2 SE',
    powerWatts: 108,
    purchasePriceMinor: 447100,
  ),
  CommonPrinter(
    name: 'Creality Sermoon V1',
    powerWatts: 46,
    purchasePriceMinor: 279400,
  ),
  CommonPrinter(
    name: 'Creality SparkX i7',
    powerWatts: 108,
    purchasePriceMinor: 558800,
  ),
  CommonPrinter(
    name: 'Elegoo Centauri',
    powerWatts: 78,
    purchasePriceMinor: 390100,
  ),
  CommonPrinter(
    name: 'Elegoo Centauri Carbon',
    powerWatts: 93,
    purchasePriceMinor: 501800,
  ),
  CommonPrinter(
    name: 'Elegoo Centauri Carbon 2 Combo',
    powerWatts: 217,
    purchasePriceMinor: 498500,
  ),
  CommonPrinter(
    name: 'Elegoo Neptune 2',
    powerWatts: 78,
    purchasePriceMinor: 166500,
  ),
  CommonPrinter(
    name: 'Elegoo Neptune 3',
    powerWatts: 62,
    purchasePriceMinor: 188900,
  ),
  CommonPrinter(
    name: 'Elegoo Neptune 3 Max',
    powerWatts: 130,
    purchasePriceMinor: 391200,
  ),
  CommonPrinter(
    name: 'Elegoo Neptune 3 Plus',
    powerWatts: 108,
    purchasePriceMinor: 278300,
  ),
  CommonPrinter(
    name: 'Elegoo Neptune 3 Pro',
    powerWatts: 62,
    purchasePriceMinor: 209000,
  ),
  CommonPrinter(
    name: 'Elegoo OrangeStorm Giga',
    powerWatts: 310,
    purchasePriceMinor: 3072400,
  ),
  CommonPrinter(
    name: 'Anycubic Kobra 2',
    powerWatts: 78,
    purchasePriceMinor: 255900,
  ),
  CommonPrinter(
    name: 'Anycubic Kobra 2 Max',
    powerWatts: 108,
    purchasePriceMinor: 501800,
  ),
  CommonPrinter(
    name: 'Anycubic Kobra 2 Plus',
    powerWatts: 78,
    purchasePriceMinor: 390100,
  ),
  CommonPrinter(
    name: 'Anycubic Kobra 2 Pro',
    powerWatts: 81,
    purchasePriceMinor: 311800,
  ),
  CommonPrinter(
    name: 'Anycubic Kobra 3',
    powerWatts: 87,
    purchasePriceMinor: 390100,
  ),
  CommonPrinter(
    name: 'Anycubic Kobra 3 Combo',
    powerWatts: 93,
    purchasePriceMinor: 501800,
  ),
  CommonPrinter(
    name: 'Anycubic Kobra 3 Max',
    powerWatts: 124,
    purchasePriceMinor: 669500,
  ),
  CommonPrinter(
    name: 'Anycubic Kobra Max',
    powerWatts: 108,
    purchasePriceMinor: 557700,
  ),
  CommonPrinter(
    name: 'Anycubic Kobra S1',
    powerWatts: 248,
    purchasePriceMinor: 501800,
  ),
  CommonPrinter(
    name: 'Anycubic Kobra S1 Max',
    powerWatts: 400,
    purchasePriceMinor: 781200,
  ),
  CommonPrinter(
    name: 'Anycubic Kobra X',
    powerWatts: 108,
    purchasePriceMinor: 390100,
  ),
  CommonPrinter(
    name: 'FlashForge AD5X',
    powerWatts: 78,
    purchasePriceMinor: 669500,
  ),
  CommonPrinter(
    name: 'FlashForge Adventurer 5M',
    powerWatts: 78,
    purchasePriceMinor: 445900,
  ),
  CommonPrinter(
    name: 'FlashForge Adventurer 5M Pro',
    powerWatts: 87,
    purchasePriceMinor: 557700,
  ),
  CommonPrinter(
    name: 'FlashForge Creator 4',
    powerWatts: 155,
    purchasePriceMinor: 2234200,
  ),
  CommonPrinter(
    name: 'Flashforge Creator Pro',
    powerWatts: 87,
    purchasePriceMinor: 502900,
  ),
  CommonPrinter(
    name: 'Qidi Max 3 Plus',
    powerWatts: 149,
    purchasePriceMinor: 1116500,
  ),
  CommonPrinter(
    name: 'Qidi Max 4',
    powerWatts: 155,
    purchasePriceMinor: 1084100,
  ),
  CommonPrinter(
    name: 'Qidi Plus 4',
    powerWatts: 118,
    purchasePriceMinor: 669500,
  ),
  CommonPrinter(
    name: 'Qidi Q1 Pro',
    powerWatts: 87,
    purchasePriceMinor: 557700,
  ),
  CommonPrinter(
    name: 'Qidi Q1 Pro 2',
    powerWatts: 93,
    purchasePriceMinor: 613600,
  ),
  CommonPrinter(name: 'Qidi Q2', powerWatts: 108, purchasePriceMinor: 514100),
  CommonPrinter(name: 'Qidi Q2C', powerWatts: 93, purchasePriceMinor: 413500),
  CommonPrinter(
    name: 'Qidi Smart 3',
    powerWatts: 78,
    purchasePriceMinor: 390100,
  ),
  CommonPrinter(
    name: 'Qidi Tech I-Mate S',
    powerWatts: 78,
    purchasePriceMinor: 445900,
  ),
  CommonPrinter(
    name: 'Qidi X-CF Pro',
    powerWatts: 124,
    purchasePriceMinor: 1341200,
  ),
  CommonPrinter(
    name: 'Qidi X-Max 3',
    powerWatts: 140,
    purchasePriceMinor: 1004800,
  ),
  CommonPrinter(
    name: 'Qidi X-Plus 3',
    powerWatts: 108,
    purchasePriceMinor: 781200,
  ),
  CommonPrinter(
    name: 'Qidi X-Smart 3',
    powerWatts: 78,
    purchasePriceMinor: 491800,
  ),
  CommonPrinter(name: 'Sovol SV04', powerWatts: 78, purchasePriceMinor: 390100),
  CommonPrinter(name: 'Sovol SV06', powerWatts: 62, purchasePriceMinor: 222400),
  CommonPrinter(
    name: 'Sovol SV06 ACE',
    powerWatts: 62,
    purchasePriceMinor: 255900,
  ),
  CommonPrinter(
    name: 'Sovol SV06 Plus',
    powerWatts: 71,
    purchasePriceMinor: 311800,
  ),
  CommonPrinter(
    name: 'Sovol SV06 Plus ACE',
    powerWatts: 93,
    purchasePriceMinor: 334200,
  ),
  CommonPrinter(name: 'Sovol SV07', powerWatts: 93, purchasePriceMinor: 334200),
  CommonPrinter(
    name: 'Sovol SV07 Plus',
    powerWatts: 108,
    purchasePriceMinor: 445900,
  ),
  CommonPrinter(
    name: 'Sovol SV08',
    powerWatts: 124,
    purchasePriceMinor: 501800,
  ),
  CommonPrinter(
    name: 'Sovol SV08 Max',
    powerWatts: 155,
    purchasePriceMinor: 669500,
  ),
  CommonPrinter(name: 'Sovol Zero', powerWatts: 62, purchasePriceMinor: 334200),
  CommonPrinter(name: 'Voron 0.2', powerWatts: 40, purchasePriceMinor: 391200),
  CommonPrinter(
    name: 'Voron 2.4',
    powerWatts: 155,
    purchasePriceMinor: 1005900,
  ),
  CommonPrinter(
    name: 'Voron 2.4 350',
    powerWatts: 155,
    purchasePriceMinor: 1005900,
  ),
  CommonPrinter(
    name: 'Voron Trident',
    powerWatts: 140,
    purchasePriceMinor: 894100,
  ),
  CommonPrinter(
    name: 'Voron Trident 300',
    powerWatts: 140,
    purchasePriceMinor: 894100,
  ),
  CommonPrinter(
    name: 'Rat Rig V-Core 3.1 300',
    powerWatts: 108,
    purchasePriceMinor: 1005900,
  ),
  CommonPrinter(
    name: 'Rat Rig V-Core 4 300',
    powerWatts: 118,
    purchasePriceMinor: 1229400,
  ),
  CommonPrinter(
    name: 'Rat Rig V-Core 4 400',
    powerWatts: 149,
    purchasePriceMinor: 1564700,
  ),
  CommonPrinter(
    name: 'Rat Rig V-Core 4 500',
    powerWatts: 186,
    purchasePriceMinor: 2011800,
  ),
  CommonPrinter(
    name: 'Rat Rig V-Minion',
    powerWatts: 56,
    purchasePriceMinor: 502900,
  ),
  CommonPrinter(
    name: 'Alfawise U20 ONE',
    powerWatts: 62,
    purchasePriceMinor: 244800,
  ),
  CommonPrinter(name: 'Annex K3', powerWatts: 78, purchasePriceMinor: 1005900),
  CommonPrinter(
    name: 'Artillery Genius Pro',
    powerWatts: 62,
    purchasePriceMinor: 278300,
  ),
];
