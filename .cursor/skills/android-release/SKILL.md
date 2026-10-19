---
name: android-release
description: >-
  Change Gramnota Android release signing, the GitHub APK workflow, or the
  Firebase SHA certificates Google sign-in needs. Use when editing
  android/app/build.gradle.kts, android/key.properties, upload-keystore.jks, or
  .github/workflows/android-apk.yml.
---

# Android release

Package id is `se.gramnota.app`. The private repo is `Mahinika/gramnota`. Debug installs and the GitHub APK use different certificates. Google sign-in works only when that certificate's SHA-1 is on the Firebase Android app and in `android/app/google-services.json`.

## Local signing

- Debug builds use the machine debug keystore.
- Release builds use `android/app/upload-keystore.jks` when `android/key.properties` exists (`storeFile`, `storePassword`, `keyAlias`, `keyPassword`). Both files are gitignored.
- `android/app/build.gradle.kts` falls back to the debug signing config when `key.properties` is absent, so a checkout without the keystore still builds.

## GitHub APK

`.github/workflows/android-apk.yml` runs on push to `master` and on `workflow_dispatch`. It writes the keystore and `google-services.json` from secrets, builds `flutter build apk --release`, and uploads `Gramnota.apk` on the shared `latest` release. `.github/scripts/publish_release.sh` replaces only that APK and the Android line in the release notes. It does not delete the Windows assets. The older `android` release keeps `app-release.apk`; its notes point at `latest`.

Secrets: `GOOGLE_SERVICES_JSON`, `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_PASSWORD`. Do not print those values.

A push to `master` publishes a new APK. Ask before pushing when the only change is unrelated to a release.

## New certificate

1. Add the SHA-1 and SHA-256 with `firebase apps:android:sha:create` for app `1:877210506403:android:1ceb0b0dc89a303655db16` in project `gramnota-2c353`.
2. Download a fresh `google-services.json` and confirm it has an OAuth Android client (`client_type` 1) whose `certificate_hash` is the new SHA-1. Keep the existing debug client.
3. Update the `GOOGLE_SERVICES_JSON` secret. Update the keystore secrets if the key file or passwords changed.
4. Changing the upload key means an installed GitHub APK must be uninstalled before the new file will install.
