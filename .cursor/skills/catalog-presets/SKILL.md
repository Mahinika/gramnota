---
name: catalog-presets
description: >-
  Add or change Gramnota workshop catalog presets (common printers and filament
  spools), quick-add chips, or search-and-fill on new printer/spool forms. Use
  when editing common_printers.dart, common_spools.dart, workshop setup printer
  step, printers_screen.dart, or filaments_screen.dart preset UI.
---

# Catalog presets

Starting inventory uses static catalogs in domain code, not Firestore. UI copy is English. Money is minor units (öre).

## Printers — `lib/features/printers/domain/common_printers.dart`

- `CommonPrinter`: `name`, `powerWatts`, `purchasePriceMinor`. Shared `CommonPrinter.lifetimeHours` (5000) for wear math in quotes.
- `commonPrinters` is the full list. Document price sources in file comments when adding rows (shop / ECB / catalog rules already described there).
- **Workshop setup** (`workshop_setup_screen.dart`): printer step picks from `commonPrinters` (search + dropdown), same as **new printer** in `printers_screen.dart`.
- Saving a printer still goes through `UserStore.savePrinter`; presets only prefill the form.

## Filament spools — `lib/features/filaments/domain/common_spools.dart`

- `CommonSpool`: `brand`, `material`, `colorLabel`, `colorHex`, `spoolWeightGrams` (default 1000), `pricePerSpoolMinor` (indicative shop price; `0` means user must set price).
- `label` is `brand material · colorLabel`. Filter with `matchingCommonSpools(query)`.
- **List screen** (`filaments_screen.dart`): search and a Low stock filter. App bar and empty state open `_StandardSpoolSheet`; a tap calls `_addStandardSpool` and saves a full spool (`remainingGrams == spoolWeightGrams`). Snackbar **Edit price** opens `/filaments/{id}`.
- **New spool** (`id == 'new'`): search field + dropdown applies `_applyPreset` to manual fields; user can still edit before save.
- Do not store `pricePerKgMinor`; pricing uses `FilamentSpool.pricePerKgMinor` at quote time.

## Adding a preset

1. Append to the const list in the domain file; keep entries realistic for Swedish shops when you set a default price.
2. For spools, pick a distinct `colorHex` and a short `colorLabel` for the chip text.
3. For printers, follow existing naming (`Brand Model`) and the power/price conventions in `common_printers.dart`.
4. No code generation; no Firestore migration.

## Out of scope

- Quote math (`quote-pricing`), stock deduction (`firestore-data`), or model-link import (`link-import`).
