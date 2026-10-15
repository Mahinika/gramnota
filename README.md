# Gramnota

Gramnota works out a sale price for a 3D print. It runs as an Android app and as a Windows desktop app from the same Flutter project.

A quote can include filament, electricity, machine wear, a failure buffer, labor, extras, markup, and VAT. Customers, filament spools, and printers stay with the signed-in user. Marking an order printed takes filament out of stock. A PDF quote can be shared from the order.

## Firebase

The app compiles before Firebase is connected and shows a setup screen until `lib/firebase_options.dart` has real keys.

1. Create a Firebase project, enable Google sign-in, and create a Firestore database.
2. `dart pub global activate flutterfire_cli`
3. `flutterfire configure` (this overwrites `lib/firebase_options.dart` and writes `android/app/google-services.json`).
4. Add the debug SHA-1 so Google sign-in works on Android: `cd android` then `./gradlew signingReport`.
5. Deploy rules: `firebase deploy --only firestore:rules` using [firestore.rules](firestore.rules).

`google-services.json` is gitignored. The placeholder `firebase_options.dart` is not a secret; replace it with the file FlutterFire generates. Include both the Android and Windows apps when you configure Firebase.

On Android, sign-in uses the Google Sign-In plugin. On Windows, sign-in opens the browser through Firebase Auth.

## Run

```
flutter run -d android
flutter run -d windows
```

## Model links

Paste a link, or on Android share it into the app.

- MakerWorld, Printables, and Creality Cloud fill the title, print time, and filament grams.
- Thingiverse, Thangs, Cults3D, MyMiniFactory, Makeronline, Nexprint, and GrabCAD fill the title when the page publishes one, and say that time and weight were not published. If that page links to MakerWorld, Printables, or Creality Cloud, Gramnota follows that link once.
- The price still comes from your own spools.

## Later

G-code import, duplicating an order as a new quote, a saved product catalog, and quotes with several different prints are not in this version.
