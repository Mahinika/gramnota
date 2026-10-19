import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/format.dart';
import 'package:gramnota/core/money.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';

void main() {
  test('parses Swedish and dotted amounts into öre', () {
    expect(parseMinor('19.99'), 1999);
    expect(parseMinor('19,99'), 1999);
    expect(parseMinor('1 234,50'), 123450);
    expect(parseMinor('1\u00a0234,50'), 123450);
    expect(parseMinor('1,005'), 101);
    expect(parseMinor('0.1'), 10);
    expect(parseMinor('.5'), 50);
    expect(parseMinor('12.'), 1200);
    expect(parseMinor(''), isNull);
    expect(parseMinor('-1'), isNull);
    expect(parseMinor('12.5.0'), isNull);
  });

  test('parses percents into basis points', () {
    expect(parseBasisPoints('25'), 2500);
    expect(parseBasisPoints('12,5'), 1250);
    expect(parseBasisPoints('12.255'), 1226);
    expect(parseBasisPoints('-5'), isNull);
  });

  test('formats SEK with a comma and kr', () {
    expect(formatMoney(1999, 'SEK'), '19,99 kr');
    expect(formatMoney(123450, 'sek'), '1\u00a0234,50 kr');
    expect(formatMoney(-150, 'SEK'), '-1,50 kr');
    expect(formatMoney(0, 'NOK'), '0,00 kr');
  });

  test('formats minor units for a text field without float noise', () {
    expect(formatMinorAmount(1999), '19.99');
    expect(formatMinorAmount(150), '1.50');
    expect(formatMinorAmount(200), '2');
    expect(formatMinorAmount(0), '0');
  });

  test('derives the kilogram price from the spool', () {
    const kilo = FilamentSpool(
      id: 'a',
      brand: 'Bambu',
      material: 'PLA',
      spoolWeightGrams: 1000,
      pricePerSpoolMinor: 24900,
    );
    const shortSpool = FilamentSpool(
      id: 'b',
      brand: 'Bambu',
      material: 'PLA',
      spoolWeightGrams: 750,
      pricePerSpoolMinor: 15000,
    );
    const empty = FilamentSpool(
      id: 'c',
      brand: 'Bambu',
      material: 'PLA',
      spoolWeightGrams: 0,
      pricePerSpoolMinor: 15000,
    );

    expect(kilo.pricePerKgMinor, 24900);
    expect(shortSpool.pricePerKgMinor, 20000);
    expect(empty.pricePerKgMinor, 0);
  });
}