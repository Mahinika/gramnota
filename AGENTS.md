# Gramnota

Flutter app that quotes a sale price for a 3D print. Package name `gramnota`. Same project runs on Android and Windows. UI copy is English. The default currency is SEK.

## Commands

- Analyze: `flutter analyze`
- Test: `flutter test`
- Run: `flutter run -d android` or `flutter run -d windows`
- After editing a Freezed or JSON model: `dart run build_runner build --delete-conflicting-outputs`
- Firestore rules live in `firestore.rules`. Ask before `firebase deploy`.

## Layout

```
lib/
  main.dart, app.dart, router.dart, firebase_options.dart
  core/          theme, money, format, UserStore, providers, shell, app_redirect, gate_scaffold
  features/<name>/domain|data|presentation
```

Features: `pricing`, `orders`, `customers`, `filaments`, `printers`, `settings`, `auth`, `import`, `sharing`.

Navigation is a `StatefulShellRoute` in `router.dart`: Calculator, Orders, Customers, Filament, More (printers, settings, inbox). `AppShell` uses a navigation rail at width >= 840 and a bottom bar otherwise.

Startup gates run before the shell: `initialLocation` `/starting`, then `resolveRedirect` and `workshopRedirect` in `lib/core/app_redirect.dart`. Unsigned users go to `/sign-in`; unconfigured Firebase to `/setup`; unknown or unfinished workshop setup to `/starting` or `/workshop-setup`. Pre-app screens use `GateScaffold`. `SetupFinished` bypasses setup only for the uid that just saved, via `setupBypassForUid`.

Calculator deep links: `?orderId=` and optional `&lineId=` reload a saved print. Each `QuoteLine` stores `sourceUrl` for the model link. New calculator forms default prep and post to 15 minutes (`defaultPrepPostMinutes`).

## Money and pricing

Money is integer minor units (öre). `100` minor is one currency unit. Percents are basis points: `10000` is 100%. Defaults in `WorkshopSettings`: markup `3000` (30%), VAT `2500` (25%).

Parse typed amounts with `parseMinor` and `parseBasisPoints` in `lib/core/money.dart`. Display with `formatMoney` and `formatPercent` in `lib/core/format.dart`.

`PriceCalculator` is pure. Quantity scales material, electricity, machine wear, the failure buffer, and labor. Extras stay a flat amount. Failure is a percent of material + electricity + machine. Markup applies to full cost. VAT applies to net (cost + markup). Filament price per kilogram is derived from spool price and spool weight (`FilamentSpool.pricePerKgMinor`); it is not stored.

A quote stores each print as a `QuoteLine`. `PriceCalculator` prices one line. `sumBreakdowns` adds those saved totals. `orderPrints` treats an order with no lines as one print, so older documents still decode. Several lines leave the legacy filament fields empty. Stock sums `grams * quantity` on each line.

## Data

`UserStore` is the only Firestore gateway, scoped to the signed-in uid:

- `users/{uid}/settings/main` — `WorkshopSettings`, including `nextQuoteNumber`
- `users/{uid}/printers|filaments|customers|orders|inbox`
- `userDirectory/{lowercaseEmail}` — uid lookup so one user can send an item to another

Persisted models are Freezed + `json_serializable`, with `explicit_to_json` in `build.yaml`. Do not hand-edit `*.freezed.dart` or `*.g.dart`. Ids are client UUIDs, except inbox documents created by Firestore. Timestamps are UTC ISO-8601 strings. `UserStore._watch` injects the document id and skips a document that fails to decode.

`OrderStock.allocateQuoteNumber` increments `nextQuoteNumber` in a transaction. Stock moves only when status enters or leaves `printed` / `delivered` (`statusHoldsStock`). A short spool still deducts what remains and stores `stockWarning` plus `deductedGrams` on the order.

Inbox is the only cross-user write. The payload is a JSON string (`payloadJson`), not a nested map. Keep `firestore.rules` in step with any new field the create rule requires.

## Auth and platforms

`firebaseIsConfigured` is false while an API key starts with `REPLACE`. An unconfigured build shows `SetupScreen` and does not touch Firebase. Android sign-in uses `google_sign_in`. Windows sign-in uses Firebase Auth in the browser; Windows is registered as a Firebase web app. `android/app/google-services.json` is gitignored. Do not commit secrets.

A signed-in user with no settings document, or with `setupCompleted` false, goes to `/workshop-setup` and walks through the workshop profile and one printer. A saved document that has no `setupCompleted` field counts as already set up.

Share-into-app (`receive_sharing_intent`) is Android only. The URL lands in `pendingLinkProvider` for the calculator.

## Link import

`LinkImportService` fills a quote from a model URL. MakerWorld, Printables, and Creality Cloud supply title, print time, and filament grams. Thingiverse, Thangs, Cults3D, MyMiniFactory, Makeronline, Nexprint, and GrabCAD supply a title when the page has one, and hop once to a supported link if the HTML contains one. The sale price still comes from the user's spools. Importers take a `TextFetcher` so tests do not hit the network.

## UI

Screens are `ConsumerWidget` or `ConsumerStatefulWidget` and read `userStoreProvider`. Confirm deletes with `confirmDelete`. Empty lists use `EmptyView`. Theme is `buildGramnotaTheme()`. Quote PDFs go through `shareQuotePdf` and the Noto Sans files in `assets/fonts/`.

## Tests

- `test/price_calculator_test.dart` — pricing math
- `test/order_stock_test.dart` — quote numbers and stock, via `fake_cloud_firestore`
- `test/link_import_test.dart` — importers with a fake fetcher
- `test/widget_test.dart` — breakdown card
- `test/workshop_setup_test.dart` — setup flag on old settings, `resolveRedirect`, and `setupBypassForUid`

Add or update a test when changing the calculator, stock transitions, or an importer.

## Leave out of this version

G-code import, duplicating an order as a new quote, and a saved product catalog.

## Skills

Read the matching file in `.cursor/skills/` before changing that area:

- `quote-pricing` — `PriceCalculator`, minor units, basis points, calculator prep/post and `sourceUrl`
- `link-import` — a model URL, `LinkImportService`, a new host
- `firestore-data` — `UserStore`, `OrderStock`, `firestore.rules`, inbox
- `app-navigation` — startup gates, `app_redirect`, `GateScaffold`, `AppShell`, workshop setup routing

## Working agreements

- Keep pricing and stock rules in `PriceCalculator` and `OrderStock`, not in widgets.
- Stay on Android and Windows unless asked to add a platform.
- Ask before deploying Firebase, pushing, or publishing.
