# Gramnota

Gramnota works out a sale price for a 3D print. It runs as an Android app and as a Windows desktop app from the same Flutter project.

A quote can include filament, electricity, machine wear, a failure buffer, labor, extras, markup, and VAT. One quote can hold several different prints, with one total and one stock deduction. Customers, filament spools, and printers stay with the signed-in user. Marking an order printed takes filament out of stock. A PDF quote can be shared from the order.

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

On Android, sign-in uses the Google Sign-In plugin. On Windows, sign-in opens the browser through Firebase Auth.

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

The same flag works with `-d windows` or a web server. The sign-in screen then offers **Sign in as test seller** (`seller@gramnota.test`). That account is created on the Auth emulator the first time you use it. The emulator UI is at http://127.0.0.1:4000. Rules from [firestore.rules](firestore.rules) apply.

## Android APK (GitHub)

Every push to `master` builds a release APK in [GitHub Actions](.github/workflows/android-apk.yml) and publishes it on the **`android`** release:

https://github.com/Mahinika/gramnota/releases/tag/android

Download `app-release.apk` while signed in to GitHub (the repo is private). The workflow needs repository secrets: `GOOGLE_SERVICES_JSON`, `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, and `ANDROID_KEY_PASSWORD`.

If you change the upload keystore, register the new SHA-1/SHA-256 in Firebase, refresh `GOOGLE_SERVICES_JSON`, and **uninstall** the old APK before installing the new one (Android treats it as a different app when the signature changes).

## Model links

Paste a link, or on Android share it into the app.

- MakerWorld, Printables, and Creality Cloud fill the title, print time, and filament grams.
- Thingiverse, Thangs, Cults3D, MyMiniFactory, Makeronline, Nexprint, and GrabCAD fill the title when the page publishes one, and say that time and weight were not published. If that page links to MakerWorld, Printables, or Creality Cloud, Gramnota follows that link once.
- The price still comes from your own spools.

## Later

G-code import, duplicating an order as a new quote, and a saved product catalog are not in this version.
