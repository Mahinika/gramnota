---
name: screen-layout
description: >-
  Change Gramnota list screens, cards, section headings, or the wide calculator
  columns. Use when editing menu_card.dart, section_layout.dart, orders,
  customers, filaments, printers, inbox, or More list UI.
---

# Screen layout

UI copy is English. List chrome lives in two core widgets. Do not invent a second card style.

## List rows — `lib/core/menu_card.dart`

`TappableListCard` is the tappable card. `listPadding` and `listSeparator` space a `ListView.separated`. The class used to be named `MenuCard`. Keep the name `TappableListCard`. Importing a screen file only to reuse a widget pulls in that screen's providers and has crashed hot reload.

## Sections — `lib/core/section_layout.dart`

- `SectionHeading` — block title.
- `DetailRow` — label on the left, value on the right. `BreakdownCard` uses it.
- `SectionRule` — horizontal divider between major blocks.

On a form, leave space between filled fields so they do not touch. Put a color swatch inside the color field, not beside it overlapping the outline. Tab and More icons are `GramnotaSvgIcon` assets, not a second set of Material symbols.

## Screen habits

- Empty collections use `EmptyView`, with an action button when the next step is obvious.
- Search sits above the list. Status or stock filters are horizontal `FilterChip`s.
- Deletes go through `confirmDelete`.
- Wide layouts (width >= 840) may split a form and its summary with a `VerticalDivider`. The shell rail uses the same breakpoint.
- After a visible change, hot reload a running debug session. Hot restart when a widget class was renamed, a plugin was added, or controller text must reload.
- Quote customer choice goes through `pickCustomerId` in `customer_quote_picker.dart`. Do not build a second picker.
- `Customer.initials` is the shared avatar text. Do not format initials in a screen.
