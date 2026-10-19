import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:gramnota/core/format.dart';
import 'package:gramnota/core/money.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';

void main() {
  test('parses Swedish and dotted amounts into öre', () {
    expect(parseMinor('19.99'), 1999);
    expect(parseMinor('19,99'), 1999);
    expect(parseMinor('1 234,50'), 123450);
    expect(parseMinor('1\u00a0234,50'), 123450);
    expect(parseMinor('1.234,50'), 123450);
    expect(parseMinor('1,234.50'), 123450);
    expect(parseMinor('1,005'), 101);
    expect(parseMinor('0.1'), 10);
    expect(parseMinor('.5'), 50);
    expect(parseMinor('12.'), 1200);
    expect(parseMinor(''), isNull);
    expect(parseMinor('-1'), isNull);
    expect(parseMinor('12.5.0'), isNull);
    expect(parseMinor('12😀'), isNull);
    expect(parseMinor('999999999999'), 99999999999900);
    expect(parseMinor('1000000000000'), isNull);
    expect(parseMinor('9' * 40), isNull);
  });

  test('parses percents into basis points', () {
    expect(parseBasisPoints('25'), 2500);
    expect(parseBasisPoints('12,5'), 1250);
    expect(parseBasisPoints('12.255'), 1226);
    expect(parseBasisPoints('-5'), isNull);
  });

  test('formats SEK with a comma and kr', () {
    expect(formatMoney(1999, 'SEK', locale: 'sv'), '19,99\u00a0kr');
    expect(formatMoney(123450, 'sek', locale: 'sv'), '1\u00a0234,50\u00a0kr');
    expect(formatMoney(-150, 'SEK', locale: 'sv'), '\u22121,50\u00a0kr');
    expect(formatMoney(0, 'NOK', locale: 'sv'), '0,00\u00a0kr');
  });

  test('formats a stored timestamp as a local date', () {
    final parsed = DateTime.parse('2026-11-02T23:30:00.000Z').toLocal();
    expect(
      formatIsoDate('2026-11-02T23:30:00.000Z', locale: 'sv'),
      DateFormat.yMMMd('sv').format(parsed),
    );
    expect(
      formatIsoDate('2026-11-02T23:30:00.000Z', locale: 'de'),
      DateFormat.yMMMd('de').format(parsed),
    );
    expect(formatIsoDate('not-a-date'), 'not-a-date');
    expect(formatIsoDate('short'), 'short');
  });

  test('formats leftover seconds in a print time', () {
    expect(formatDuration(0), '0m');
    expect(formatDuration(14), '14s');
    expect(formatDuration(1514), '25m 14s');
    expect(formatDuration(5400), '1h 30m');
    expect(formatDuration(5414), '1h 30m 14s');
  });

  test('formats minor units for a text field without float noise', () {
    expect(formatMinorAmount(1999), '19.99');
    expect(formatMinorAmount(150), '1.50');
    expect(formatMinorAmount(200), '2');
    expect(formatMinorAmount(0), '0');
    expect(formatMinorField(1999, locale: 'sv'), '19,99');
    expect(formatMinorField(200, locale: 'sv'), '2');
    expect(formatDecimalField(12.5, fractionDigits: 3, locale: 'sv'), '12,5');
    expect(formatDecimalField(10, locale: 'sv'), '10');
    expect(formatPercent(1250, locale: 'sv'), '12,50%');
    expect(formatPercent(2500, locale: 'sv'), '25%');
    expect(calendarDayStamp(DateTime(2026, 3, 15)), '2026-03-15T12:00:00.000Z');
    expect(
      calendarDayOf('2026-03-15T12:00:00.000Z'),
      DateTime(2026, 3, 15),
    );
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