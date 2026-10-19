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

`users/{uid}/**` is read-write for that uid. The inbox create rule is the only cross-user write: the sender is signed in, `senderUid` is `request.auth.uid`, and `keys().hasAll` lists every field `InboxItem.toJson()` writes. `payloadJson` is a JSON string, not a map. A new required inbox field must be added to that list and to `sendToUser`.

`userDirectory` create and update require `request.resource.data.uid == request.auth.uid` and a document id equal to `request.auth.token.email.lower()`.

Do not deploy. After `firestore.rules` changes, tell the user to run `firebase deploy --only firestore:rules`.
