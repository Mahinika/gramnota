---
name: app-navigation
description: >-
  Change Gramnota startup gates, go_router redirects, AppShell, GateScaffold,
  workshop setup routing, or sign-in flow. Use when editing router.dart,
  app_redirect.dart, gate_scaffold.dart, shell.dart, or workshop_setup_test
  redirect cases.
---

# App navigation

The shell is never the first screen. Gates run outside `AppShell` until Firebase is configured, the user is signed in, and workshop setup is known and finished.

## Redirect logic

Pure functions live in `lib/core/app_redirect.dart`:

- `resolveRedirect` — full chain: `/setup` → `/starting` while auth loads → `/sign-in` when signed out → `workshopRedirect` when signed in.
- `workshopRedirect` — `/starting` while `setupCompleted` is null (unless `finishedLocally`), `/workshop-setup` when setup is unfinished, then `/calculator` when leaving gate routes.

`lib/router.dart` wires `GoRouter`: `initialLocation` is `/starting`, `redirect` calls `resolveRedirect`, and `refreshListenable` listens to `authUserProvider`, `setupCompletedProvider`, and `setupFinishedProvider`.

Do not return `null` from redirect while auth is still loading. That would build the shell on the first frame.

## Workshop setup bypass

`SetupFinished` in `workshop_setup_screen.dart` sets `finishedLocally` so a slow settings snapshot does not send the user back into the guide after save. `mark()` stores the uid; `build()` returns true only when the current uid matches (`setupBypassForUid`). Sign-out or another account must not inherit bypass.

`setupCompletedProvider` is `null` while settings load, `true` on stream error (do not block on `/starting` forever), otherwise `WorkshopSettings.setupCompleted`. A document without `setupCompleted` counts as done.

## Routes

| Route | Role |
|-------|------|
| `/setup` | Firebase not configured |
| `/starting` | Spinner gate |
| `/sign-in` | Google sign-in |
| `/workshop-setup` | Nine-step workshop guide (outside shell) |
| `/calculator`, `/orders`, … | `StatefulShellRoute` branches in `AppShell` |

Pre-app screens use `GateScaffold` and `GramnotaBrandMark` (`lib/core/gate_scaffold.dart`). Brand assets are under `assets/brand/`.

`AppShell` (`lib/core/shell.dart`): five destinations, rail at width ≥ 840 with `groupAlignment: -1` and the brand mark in `leading`; bottom `NavigationBar` on narrow layouts.

## Calculator deep links

- New quote: `/calculator`
- Add print on a quote: `/calculator?orderId=…`
- Edit saved print: `/calculator?orderId=…&lineId=…`

`pendingLinkProvider` (Android share) is consumed in `CalculatorScreen` after the user reaches the calculator.

## Tests

Redirect cases belong in `test/workshop_setup_test.dart` (imports from `app_redirect.dart` and `setupBypassForUid` from workshop setup). Run `flutter test test/workshop_setup_test.dart` after redirect changes.

## Out of scope here

Do not change `PriceCalculator`, `OrderStock`, or Firestore rules in this skill. Keep shell branch paths and nested `context.go` detail routes unless navigation structure itself changes.
