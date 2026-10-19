---
name: firestore-data
description: >-
  Change Gramnota Firestore data, security rules, UserStore collections, inbox
  sharing, quote numbers, or filament stock. Use when editing firestore.rules,
  UserStore, OrderStock, a Freezed model that is saved, or sendToUser.
---

# Firestore data

`UserStore` is the only gateway. A new persisted thing gets a collection getter, `watch` / `save` / `delete`, and a place in `deleteOwnedData`.

## Documents

- Path is `users/{uid}/...`, except `userDirectory/{lowercaseEmail}`.
- Models are Freezed with `@Default` on every new field so an old document still decodes. Run `dart run build_runner build --delete-conflicting-outputs`. Do not edit `*.freezed.dart` or `*.g.dart` by hand.
- `_watch` copies `id` from the document id and skips a document that throws. Keep `fromJson` tolerant.
- Client ids are UUIDs. Inbox ids are the Firestore document id from `sendToUser`. Timestamps are UTC ISO-8601 strings.

## Stock and quote numbers

`OrderStock` owns both, inside `runTransaction`.

- `allocateQuoteNumber` reads `settings/main`, uses `nextQuoteNumber` (minimum 1), and writes the next value.
- Stock moves only when status crosses `statusHoldsStock` (`printed` and `paid`). Deduct the sum of `grams * quantity` per spool, clamp at zero, and store the amount actually taken in `deductedGrams`. Moving between Printed and Paid does not deduct again. `delivered` in old JSON decodes as `paid`.
- Leaving those statuses adds `deductedGrams` back and clears `stockDeducted` and `stockWarning`.
- Do not update `remainingGrams` from a screen.

A stock change needs a `fake_cloud_firestore` test in `test/order_stock_test.dart`.

## Rules

Workshop collections (`settings`, `printers`, `filaments`, `customers`, `orders`, `products`) are read-write for that uid only, through one shared rule. Products are not a separate policy. `users/{uid}` itself is get and delete for the owner. Anything else is denied.

`userDirectory/{lowercaseEmail}` stores `uid` and `displayName` only. The email is the document id. `allow get` for any signed-in user. Do not allow `list` or a collection query. Create and update require a verified email, `request.resource.data.uid == request.auth.uid`, and a document id equal to `request.auth.token.email.lower()`. An optional `email` field is accepted only when it equals that id, so the released app can still publish its directory row.

The inbox create rule is the only cross-user write. The sender is a different verified user, `senderUid` is `request.auth.uid`, `senderEmail` is `request.auth.token.email`, and `createdAt` is `request.time` (`FieldValue.serverTimestamp()`). `keys().hasOnly` whitelists `type`, `payloadJson`, `senderUid`, `senderName`, `senderEmail`, `createdAt`, and an optional `id` equal to the document id. `payloadJson` is a JSON object string, at most 100000 characters. The sender must already have a `userDirectory` row whose `uid` is theirs. The owner can read and delete inbox items, not update them. A new inbox field must be added to that whitelist and to `sendToUser`.

Do not turn on App Check enforcement. Flutter Windows has no App Check provider, and Firestore enforcement is project-wide, so it would reject the Windows app.

Rules tests live in `test/firestore_rules` (`npm test`) and run against the Firestore emulator. Do not deploy. After `firestore.rules` changes, tell the user to run `firebase deploy --only firestore:rules`.
