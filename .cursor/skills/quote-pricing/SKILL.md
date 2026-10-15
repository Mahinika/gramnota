---
name: quote-pricing
description: >-
  Change Gramnota quote math, cost lines, minor units, or basis points.
  Use when editing PriceCalculator, PriceBreakdown, parseMinor, parseBasisPoints,
  the breakdown card, a quote PDF total, or pricing tests.
---

# Quote pricing

`PriceCalculator.calculate` is the only place a cost line is derived. Screens and the PDF display `PriceBreakdown`; they do not recompute it.

## Units

- Money fields end in `Minor` and are integers. `100` is one currency unit.
- Percent fields are basis points. `10000` is 100%. Divide by `10000` in the formula, never by `100`.
- Round each line with `.round()` after the multiplication, in the same order as the existing method.
- Parse typed input with `parseMinor` and `parseBasisPoints`. Display with `formatMoney` and `formatPercent`.

## Formula order

1. Scale material, electricity, and machine wear by `quantity`.
2. Failure is basis points of those three lines only, after scaling.
3. Scale labor by `quantity`. Leave `extraMinors` as a flat sum.
4. Markup is basis points of the full cost. VAT is basis points of net (cost + markup).
5. `perUnitMinor` is `totalMinor / quantity`, rounded. Quantity below 1 is treated as 1.
6. Filament kroner per kilogram comes from `FilamentSpool.pricePerKgMinor` (spool price / spool weight). Do not store that rate.

## When a breakdown field changes

Update the Freezed model, `PriceBreakdown.zero()`, then run:

```
dart run build_runner build --delete-conflicting-outputs
```

Every `PriceBreakdown(...)` constructor must still compile, including `test/order_stock_test.dart` and `test/widget_test.dart`. Update `breakdown_card.dart` and `quote_pdf.dart` if the new line is shown to the user.

## Tests

Add a case in `test/price_calculator_test.dart` with the expected integers written out. Run `flutter test test/price_calculator_test.dart` and, if the card changed, `flutter test test/widget_test.dart`.
