---
name: link-import
description: >-
  Add or change a Gramnota model-link importer for MakerWorld, Printables,
  Creality Cloud, or a title-only host. Use when the user pastes a model URL,
  mentions print time or filament grams from a site, or edits LinkImportService.
---

# Link import

`LinkImportService.importUri` picks an importer. The sale price stays on the user's spools. An importer returns title, print time, and grams only.

## Where a site goes

Full profile (time and grams exist behind an API or embedded payload):

- Add a class with `canHandle(Uri)` and `import(Uri uri, TextFetcher fetcher)`.
- Pass it into `LinkImportService` and call it from `importUri` before the `titleOnlyHosts` branch.
- Follow MakerWorld (`fetcher.get` on a JSON API), Printables (`fetcher.postJson` GraphQL), or Creality (`fetcher.get` on the page, then parse the embedded payload).

Title only:

- Add the host to `LinkImportService.titleOnlyHosts`.
- Do not invent print time or grams. Return `missing: ['print time', 'filament weight']` and a `note` the user can read.

A title-only page may contain one `https://` link to MakerWorld, Printables, or Creality Cloud. `_supportedLink` follows that link once. The second call uses `allowHop: false`. Do not add another hop.

## Fetching

Importers take the `TextFetcher` argument. They do not construct `http` clients. Tests use `_FakeFetcher` in `test/link_import_test.dart`:

- GET fixtures are keyed by the full URI string, then by `host + path`.
- POST fixtures are keyed by `POST ${uri.host}`.

A bad URL returns an `ImportResult` with a note. A response that is not the expected shape throws `FormatException`.

## Tests

Add a fixture test that asserts title, `printTimeSeconds`, and grams. Run `flutter test test/link_import_test.dart`.
