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

Features: `pricing`, `orders`, `customers`, `filaments`, `printers`, `settings`, `auth`, `import`, `sharing`, `catalog`.

Navigation is a `StatefulShellRoute` in `router.dart`: Home, Calculator, Orders, Customers, Filament, More (products, printers, settings, inbox). `AppShell` uses a navigation rail at width >= 840 and a bottom bar otherwise. Home is the month dashboard. After workshop setup the app still opens the calculator.

Startup gates run before the shell: `initialLocation` `/starting`, then `resolveRedirect` and `workshopRedirect` in `lib/core/app_redirect.dart`. Unsigned users go to `/sign-in`; unconfigured Firebase to `/setup`; unknown or unfinished workshop setup to `/starting` or `/workshop-setup`. Pre-app screens use `GateScaffold`. `SetupFinished` bypasses setup only for the uid that just saved, via `setupBypassForUid`.

Calculator deep links: `?orderId=` and optional `&lineId=` reload a saved print. Each `QuoteLine` stores `sourceUrl` for the model link. New calculator forms default prep and post to 15 minutes (`defaultPrepPostMinutes`).

## Money and pricing

Money is integer minor units (öre). `100` minor is one currency unit. Percents are basis points: `10000` is 100%. Defaults in `WorkshopSettings`: markup `3000` (30%), VAT `2500` (25%).

Parse typed amounts with `parseMinor` and `parseBasisPoints` in `lib/core/money.dart`. Display with `formatMoney` and `formatPercent` in `lib/core/format.dart`.

`PriceCalculator` is pure. Quantity scales material, electricity, machine wear, the failure buffer, and production labor. Prep labor is charged once. Post labor is charged per unit. Extras stay a flat amount. Failure is a percent of material + electricity + machine. Markup applies to full cost. VAT applies to net (cost + markup). Filament price per kilogram is derived from spool price and spool weight (`FilamentSpool.pricePerKgMinor`); it is not stored.

A quote stores each print as a `QuoteLine`. `PriceCalculator` prices one line. `sumBreakdowns` adds those saved totals. `orderPrints` treats an order with no lines as one print, so older documents still decode. Several lines leave the legacy filament fields empty. Stock sums `grams * quantity` on each line.

## Data

`UserStore` is the only Firestore gateway, scoped to the signed-in uid:

- `users/{uid}/settings/main` — `WorkshopSettings`, including `nextQuoteNumber`
- `users/{uid}/printers|filaments|customers|orders|products|inbox`
- `userDirectory/{lowercaseEmail}` — uid lookup so one user can send an item to another

Persisted models are Freezed + `json_serializable`, with `explicit_to_json` in `build.yaml`. Do not hand-edit `*.freezed.dart` or `*.g.dart`. Ids are client UUIDs, except inbox documents created by Firestore. Timestamps are UTC ISO-8601 strings. `UserStore._watch` injects the document id and skips a document that fails to decode.

`OrderStock.allocateQuoteNumber` increments `nextQuoteNumber` in a transaction. Stock moves only when status enters or leaves `printed` / `paid` (`statusHoldsStock`). Printed and Paid both hold stock, so moving between them does not deduct again. Leaving them returns `deductedGrams`. A short spool still deducts what remains and stores `stockWarning` plus `deductedGrams` on the order. `revenueAt` is stamped the first time stock is taken and cleared when stock comes back. Older `delivered` documents decode as `paid`. `depositMinor` is an optional amount already paid.

Inbox is the only cross-user write. The payload is a JSON string (`payloadJson`), not a nested map. Keep `firestore.rules` in step with any new field the create rule requires.

## Auth and platforms

`firebaseIsConfigured` is false while an API key starts with `REPLACE`. An unconfigured build shows `SetupScreen` and does not touch Firebase. Android sign-in uses `google_sign_in`. Windows sign-in opens the system browser on a localhost page (Firebase web Google sign-in, which `localhost` is allowed to use) and then calls `signInWithCredential`. Do not call `signInWithProvider` on Windows: the Firebase C++ SDK rejects it. Windows is registered as a Firebase web app. `android/app/google-services.json` is gitignored. Do not commit secrets, `android/key.properties`, or `*.jks`.

Release APKs are signed with the upload keystore in `android/app/upload-keystore.jks` when `android/key.properties` exists. Debug builds keep the debug keystore. Google sign-in on Android accepts only SHA-1 fingerprints registered on the Firebase Android app (`se.gramnota.app`). Both the local debug certificate and the upload certificate must stay registered, and `google-services.json` must list both OAuth Android clients.

GitHub Actions builds on every push to `master`. `.github/workflows/android-apk.yml` publishes `Gramnota.apk` and `.github/workflows/windows-release.yml` publishes `Gramnota-Setup.exe` and `Gramnota-windows.zip`, both on the shared `latest` release. The jobs update that release in place and do not delete each other's files. The older `android` and `windows` releases stay up so existing links keep working; their notes point at `latest`. CI passes `github.run_number` as the build number and publishes `latest.json` on that same release (public APK and installer URLs plus sha256). The app reads `updateManifestUrl`. The APK workflow needs the secrets `GOOGLE_SERVICES_JSON`, `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, and `ANDROID_KEY_PASSWORD`. A new signing key means the installed app must be uninstalled before the new APK can replace it. The repo is public. Do not put keystore material, `google-services.json`, or secret values in the README or the workflows.

A signed-in user with no settings document, or with `setupCompleted` false, goes to `/workshop-setup` and walks through the workshop profile, one printer, and an optional standard filament spool. A saved document that has no `setupCompleted` field counts as already set up.

Share-into-app (`receive_sharing_intent`) is Android only. A URL lands in `pendingLinkProvider` for the calculator. A shared `.gcode` or `.3mf` lands in `pendingSliceProvider` and is scanned the same way as **Import G-code**.

## Link import

`LinkImportService` fills a quote from a model URL. MakerWorld, Printables, and Creality Cloud supply title, print time, and filament grams. Thingiverse, Thangs, Cults3D, MyMiniFactory, Makeronline, Nexprint, and GrabCAD supply a title when the page has one, and hop once to a supported link if the HTML contains one. The sale price still comes from the user's spools. Importers take a `TextFetcher` so tests do not hit the network.

## UI

Screens are `ConsumerWidget` or `ConsumerStatefulWidget` and read `userStoreProvider`. Confirm deletes with `confirmDelete`. Empty lists use `EmptyView`. Theme is `buildGramnotaTheme()`; the brand green is `#0F6E56`. New surfaces use that theme (paper background, white cards, filled fields). Do not invent a second card color. Tab and More icons are the SVG files in `assets/icons/`, drawn through `GramnotaSvgIcon`. The Gramnota mark in `assets/brand/` stays the empty-state and sign-in mark.

List rows use `TappableListCard` (`lib/core/menu_card.dart`). Section titles, label/value rows, and dividers use `SectionHeading`, `DetailRow`, and `SectionRule` in `lib/core/section_layout.dart`. Shared Firestore streams for orders, customers, and settings live in `lib/features/orders/data/orders_providers.dart`. Import that file. Do not import a screen only to reach a provider.

Orders list: search, status chips (Quote, Sent, Accepted, Printed, Paid, Declined, Cancelled), and an In progress filter. Filament list: search, a Low stock filter, and standard spools in a bottom sheet (`common_spools.dart`). A spool is low at its own threshold, or at `WorkshopSettings.defaultLowStockGrams` when `lowStockUsesDefault` is set. Customers list shows `Customer.initials` and quote counts. Wide calculator layouts (width >= 840) put the price breakdown in a second column, with padding beside the divider. Recent quotes sit under the price, not inside the form. Home aggregates printed and paid orders for the selected local month (`buildDashboard`).

A new quote picks its customer on the calculator before save. The same sheet is `pickCustomerId` in `lib/features/customers/presentation/customer_quote_picker.dart` (search, no customer, new customer). Order detail uses it to link or change the customer. An empty printer or spool list on the calculator shows a setup card with a route to that screen.

## Quote PDF

`buildQuotePdf` draws the customer document. `openQuotePdfPreview` shows it with the `printing` package before `shareQuotePdf` writes a temp file and shares it. Fonts are Noto Sans in `assets/fonts/`.

The page is an invoice: workshop and bill-to side by side, quote number with issued date and valid-until, then a table of description, quantity, unit price, and amount. Those line amounts are `netMinor` (excluding VAT). The summary is Subtotal, VAT (with the rate when every line shares it), and a highlighted Total (`totalMinor`). A short material or profile note may sit under a line title. Do not print grams, the internal note, or cost words such as Material, Markup, or Net. Allowed summary labels live in `customerQuoteBreakdownFields`. Do not put the Gramnota app icon on the document; the workshop name is the brand.

## Tests

- `test/price_calculator_test.dart` — pricing math
- `test/order_stock_test.dart` — quote numbers and stock, via `fake_cloud_firestore`
- `test/order_status_test.dart` — status migration and stock explanations
- `test/dashboard_test.dart` — month totals, VAT, and low spools
- `test/stock_warning_test.dart` — quote coverage against accepted orders
- `test/dashboard_widget_test.dart` — dashboard and status chips
- `test/plate_quote_test.dart` — multi-plate import
- `test/link_import_test.dart` — importers with a fake fetcher
- `test/widget_test.dart` — breakdown card
- `test/workshop_setup_test.dart` — setup flag on old settings, `resolveRedirect`, and `setupBypassForUid`
- `test/customer_quote_view_test.dart` — customer PDF labels
- `test/customers_menu_card_test.dart` — `TappableListCard`
- `test/app_update_test.dart` — update manifest, skip-version, and download checksums

Add or update a test when changing the calculator, stock transitions, or an importer.

## G-code, duplicate quote, catalog

`GcodeImport` scans the head and tail of a `.gcode` file (`gcodeHeadBytes` / `gcodeTailBytes`) and the same edges of G-code stored in a `.3mf`. Do not read the whole toolpath into a string. `duplicateAsNewQuote` builds the new quote; `OrderStock.allocateQuoteNumber` assigns the number. It does not copy `stockDeducted`, `deductedGrams`, or `stockWarning`. `pricePrint` / `priceProduct` recompute from the current spool, printer, electricity, and labor. Markup, failure, and VAT stay on the print or product. Products live in `users/{uid}/products`.

## Skills

Read the matching file in `.cursor/skills/` before changing that area:

- `quote-pricing` — `PriceCalculator`, minor units, basis points, calculator prep/post and `sourceUrl`
- `link-import` — a model URL, `LinkImportService`, a new host
- `firestore-data` — `UserStore`, `OrderStock`, `firestore.rules`, inbox
- `app-navigation` — startup gates, `app_redirect`, `GateScaffold`, `AppShell`, workshop setup routing
- `catalog-presets` — `common_printers`, `common_spools`, quick-add and preset pickers on printer/spool screens
- `screen-layout` — `TappableListCard`, section headings, list screens, wide calculator columns
- `android-release` — upload keystore, GitHub APK workflow, Firebase SHA certificates for Google sign-in

## Working agreements

- Keep pricing and stock rules in `PriceCalculator` and `OrderStock`, not in widgets.
- Stay on Android and Windows unless asked to add a platform.
- Ask before deploying Firebase, pushing, or publishing.
- After any visible UI change (widgets, theme, assets used on screen), hot reload the running Flutter app when a debug session is attached; use hot restart if reload is not enough.
