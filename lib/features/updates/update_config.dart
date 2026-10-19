/// Public manifest for the current Gramnota build.
///
/// Override with `--dart-define=UPDATE_MANIFEST_URL=...` to point at another
/// file. The app does not embed a GitHub token.
const updateManifestUrl = String.fromEnvironment(
  'UPDATE_MANIFEST_URL',
  defaultValue:
      'https://github.com/Mahinika/gramnota/releases/download/latest/latest.json',
);
