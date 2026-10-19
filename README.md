# Gramnota

Gramnota works out a sale price for a 3D print. It runs as an Android app and as a Windows desktop app from the same Flutter project.

A quote can include filament, electricity, machine wear, a failure buffer, labor, extras, markup, and VAT. One quote can hold several different prints, with one total and one stock deduction. Customers, filament spools, and printers stay with the signed-in user. Marking an order Printed or Paid takes filament out of stock once. Cancelling or moving it back before Printed puts those grams back. A PDF quote can be shared from the order.

## Firebase

The app compiles before Firebase is connected and shows a setup screen until `lib/firebase_options.dart` has real keys.

1. Create a Firebase project, enable Google sign-in, and create a Firestore database.
2. `dart pub global activate flutterfire_cli`
3. `flutterfire configure` (this overwrites `lib/firebase_options.dart` and writes `android/app/google-services.json`).
4. Register **both** Android SHA-1 fingerprints on the Firebase Android app (`se.gramnota.app`):
   - **Debug** — `cd android` then `./gradlew signingReport` (or Android Studio signing report).
   - **Upload / release** — the certificate used for `android/app/upload-keystore.jks` when `android/key.properties` exists (GitHub APK builds use this key).
5. Download a fresh `google-services.json` so it lists an OAuth Android client for each SHA-1 you use.
6. Deploy rules: `firebase deploy --only firestore:rules` using [firestore.rules](firestore.rules).

`google-services.json`, `android/key.properties`, and `*.jks` are gitignored. The checked-in `firebase_options.dart` is not a secret; replace it with the file FlutterFire generates. Include both the Android and Windows apps when you configure Firebase.

On Android, sign-in uses the Google Sign-In plugin. On Windows, sign-in opens your browser. Continue with Google there, then return to Gramnota.

## Run

```
flutter run -d android
flutter run -d windows
```

## Local Firebase emulators

The Auth and Firestore emulators let you walk the app without Google sign-in. Production builds do not use them. Install the [Firebase CLI](https://firebase.google.com/docs/cli), then from the repo root:

```
firebase emulators:start --only auth,firestore
```

In another terminal:

```
flutter run -d chrome --dart-define=USE_FIREBASE_EMULATOR=true
```

The same flag works with `-d windows` or a web server. The sign-in screen then offers **Sign in as test seller** (`seller@gramnota.test`). That account is created on the Auth emulator the first time you use it. A browser refresh signs you out (emulator persistence is off) but keeps talking to the emulators, including when the page is opened at `127.0.0.1`. Sign in as the test seller again. The emulator UI is at http://127.0.0.1:4000. Rules from [firestore.rules](firestore.rules) apply. In the browser build, Google sign-in is not available; use the test seller button.

## Android APK (GitHub)

Every push to `master` builds a release APK in [GitHub Actions](.github/workflows/android-apk.yml) and publishes it on the **`android`** release:

https://github.com/Mahinika/gramnota/releases/tag/android

Download `app-release.apk` while signed in to GitHub (the repo is private). The workflow needs repository secrets: `GOOGLE_SERVICES_JSON`, `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, and `ANDROID_KEY_PASSWORD`.

If you change the upload keystore, register the new SHA-1/SHA-256 in Firebase, refresh `GOOGLE_SERVICES_JSON`, and **uninstall** the old APK before installing the new one (Android treats it as a different app when the signature changes).

## Windows app (GitHub)

Every push to `master` builds a release Windows app in [GitHub Actions](.github/workflows/windows-release.yml) and publishes it on the **`windows`** release:

https://github.com/Mahinika/gramnota/releases/tag/windows

Download while signed in to GitHub (the repo is private). You can also start a build from the Actions tab (**Windows release** → **Run workflow**). The workflow does not need repository secrets: Windows Firebase settings are already in `lib/firebase_options.dart`.

- `Gramnota-Setup-<version>.exe` — installer. Windows asks for administrator permission. It adds a Start menu shortcut and, unless you clear the checkbox, a desktop shortcut. Run a newer installer to upgrade in place. Uninstall later from Windows Settings, under Apps. The app is installed in `C:\Program Files\Gramnota`.
- `Gramnota-<version>-windows-x64.zip` — the same build as a folder. Unzip it and run `gramnota.exe`.

Both include the Visual C++ runtime libraries next to `gramnota.exe` (`msvcp140.dll`, `vcruntime140.dll`, `vcruntime140_1.dll`, and the other runtime DLLs from the build), so a clean Windows 10 or 11 PC does not need a separate Visual C++ download.

Windows may show "Windows protected your PC" the first time, because the app is not code-signed. Choose **More info**, then **Run anyway**.

Sign-in on Windows opens your browser. Continue with Google there, then return to the Gramnota window.

## Model links

Paste a link, or on Android share it into the app.

- MakerWorld, Printables, and Creality Cloud fill the title, print time, and filament grams.
- Thingiverse, Thangs, Cults3D, MyMiniFactory, Makeronline, Nexprint, and GrabCAD fill the title when the page publishes one, and say that time and weight were not published. If that page links to MakerWorld, Printables, or Creality Cloud, Gramnota follows that link once.
- The price still comes from your own spools.

## G-code and 3MF

On the calculator, **Import G-code** reads a `.gcode` or `.3mf` file. Gramnota scans the start and end of the file for slicer comments, so a large toolpath is not loaded into memory. PrusaSlicer, OrcaSlicer, Bambu Studio, Cura, and Creality Print supply print time and filament grams, including one row per extruder when the file lists them. A `.3mf` is used when it contains sliced G-code or plate metadata (Bambu Studio and OrcaSlicer write those into the archive). When that file has several plates, Gramnota asks whether to import all of them as separate prints on the quote, or to fill the form from one plate. The sale price still comes from your spools.

On Android you can share a link, or a file whose type is G-code or 3MF, into Gramnota. It opens on the calculator. Gramnota does not register for every `application/octet-stream` share. Android does not reliably filter those shares by file name (the path is an extra, not the intent data), so a broad binary type would offer Gramnota for unrelated files. File managers that only advertise `application/octet-stream` will not list Gramnota; share the file as G-code or 3MF, or import it from the calculator.

## Duplicate a quote

On a quote, **Duplicate as new quote** copies the prints, the customer, and the print settings. The copy is a Quote with a new number and new dates. Filament already taken out of stock stays on the original order. Prices are calculated again from the current spool prices, printer costs, electricity price, and labor rate. Markup, failure, and VAT stay as they are on each print.

## Product catalog

**More → Products** stores a print you quote again: time, filaments, printer, labor minutes, extras, and percents. Save one from the calculator (**Save as product**) or from a print on a quote. **Add from catalog** on the calculator, or **Add product** on a quote, inserts it and prices filament, electricity, and machine wear from the spools, printer, and workshop rates you have at that moment. Markup, failure, and VAT stay as saved on the product.

## Quote status

An order moves Quote → Sent → Accepted → Printed → Paid. Declined and Cancelled are the other exits. The order list has a chip for each status, plus All and In progress (everything that is not Paid, Declined, or Cancelled).

Filament leaves the spool when the order first becomes Printed or Paid. Changing Printed to Paid does not take filament again. Cancelling, declining, or moving the order back before Printed returns the grams that were actually taken, including when the spool was short. Older orders stored as Delivered open as Paid, with their stock and totals unchanged.

A deposit is optional. Until the order is Paid, the quote shows what is still to pay.

A Quote or Sent order shows Expired the day after its valid-until date.

## Home

**Home** is the month view. Printed and Paid orders in that month count as revenue (incl. VAT and excl. VAT), cost, and profit. Profit is revenue excl. VAT minus cost. The month follows the device calendar, so an order just before local midnight stays in that month. Sent and Accepted quotes are an open pipeline and are not limited to the month. The page also lists filament grams by material, top customers, top products, and spools at or under their warning threshold.

## Stock warnings

Settings has a workshop low-stock warning, 100 g unless you change it. A spool can follow that default or keep its own threshold. The filament list and Home mark a spool that is at or under the threshold.

On a quote, Gramnota warns when the chosen spools cannot cover grams times quantity, plus the same sum on other Accepted quotes that have not taken stock yet. The warning is shown before the order is marked Printed. You can still print it; a short spool only deducts what is left.
