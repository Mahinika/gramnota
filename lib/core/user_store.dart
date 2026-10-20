import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../features/catalog/domain/catalog_product.dart';
import '../features/customers/domain/customer.dart';
import '../features/filaments/domain/filament_spool.dart';
import '../features/orders/domain/print_order.dart';
import '../features/printers/domain/printer_profile.dart';
import '../features/settings/domain/workshop_backup.dart';
import '../features/settings/domain/workshop_settings.dart';
import '../features/sharing/domain/inbox_item.dart';
import 'currencies.dart';
import 'preference_echo.dart';

class UserStore {
  UserStore(this.db, this.uid);

  final FirebaseFirestore db;
  final String uid;

  final _currencyEcho = PreferenceEcho();

  /// False until [watchSettings] sees a saved settings document.
  /// A missing document is not an old Swedish workshop.
  bool _settingsDocumentExists = false;

  bool get settingsDocumentExists => _settingsDocumentExists;

  DocumentReference<Map<String, dynamic>> get settingsDoc =>
      db.collection('users').doc(uid).collection('settings').doc('main');

  CollectionReference<Map<String, dynamic>> get printers =>
      db.collection('users').doc(uid).collection('printers');

  CollectionReference<Map<String, dynamic>> get filaments =>
      db.collection('users').doc(uid).collection('filaments');

  CollectionReference<Map<String, dynamic>> get customers =>
      db.collection('users').doc(uid).collection('customers');

  CollectionReference<Map<String, dynamic>> get orders =>
      db.collection('users').doc(uid).collection('orders');

  CollectionReference<Map<String, dynamic>> get products =>
      db.collection('users').doc(uid).collection('products');

  CollectionReference<Map<String, dynamic>> get inbox =>
      db.collection('users').doc(uid).collection('inbox');

  CollectionReference<Map<String, dynamic>> get directory =>
      db.collection('userDirectory');

  Stream<WorkshopSettings> watchSettings() {
    return settingsDoc.snapshots().map((snapshot) {
      final data = snapshot.data();
      final exists = snapshot.exists && data != null;
      _settingsDocumentExists = exists;
      final settings = exists
          ? WorkshopSettings.fromJson(data)
          : const WorkshopSettings();
      return _withCurrencyHold(settings);
    });
  }

  /// Call before writing [currencyCode] with [updatedAt].
  /// An older snapshot keeps the currency that was just chosen.
  void expectCurrencyEcho(String code, String updatedAt) {
    _currencyEcho.expect(normalizeCurrencyCode(code), updatedAt);
  }

  void releaseCurrencyEcho() => _currencyEcho.release();

  WorkshopSettings _withCurrencyHold(WorkshopSettings settings) {
    final shown = _currencyEcho.resolve(
      remoteCode: settings.currencyCode,
      updatedAt: settings.currencyUpdatedAt,
    );
    if (shown == settings.currencyCode) {
      return settings;
    }
    return settings.copyWith(currencyCode: shown);
  }

  /// Writes one or more of language, appearance, and currency.
  /// The quote counter is left untouched.
  Future<void> saveLocalePreferences({
    String? languageCode,
    String? languageUpdatedAt,
    String? themeMode,
    String? themeUpdatedAt,
    String? currencyCode,
    String? currencyUpdatedAt,
  }) {
    final data = <String, dynamic>{};
    if (languageCode != null) {
      data['languageCode'] = languageCode;
      if (languageUpdatedAt != null) {
        data['languageUpdatedAt'] = languageUpdatedAt;
      }
    }
    if (themeMode != null) {
      data['themeMode'] = themeMode;
      if (themeUpdatedAt != null) {
        data['themeUpdatedAt'] = themeUpdatedAt;
      }
    }
    if (currencyCode != null) {
      data['currencyCode'] = currencyCode;
      if (currencyUpdatedAt != null) {
        data['currencyUpdatedAt'] = currencyUpdatedAt;
      }
    }
    if (data.isEmpty) {
      return Future<void>.value();
    }
    return settingsDoc.set(data, SetOptions(merge: true));
  }

  /// Writes workshop settings without [WorkshopSettings.nextQuoteNumber].
  ///
  /// The counter belongs to [OrderStock.allocateQuoteNumber]. A full
  /// document write from a screen that loaded the number earlier would
  /// hand the same quote number out twice.
  Future<void> saveSettings(WorkshopSettings settings) {
    return settingsDoc.set(
      settingsWithoutQuoteCounter(settings),
      SetOptions(merge: true),
    );
  }

  Stream<List<PrinterProfile>> watchPrinters() =>
      _watch(printers, PrinterProfile.fromJson);

  Future<void> savePrinter(PrinterProfile printer) {
    return printers.doc(printer.id).set(printer.toJson());
  }

  Future<void> deletePrinter(String id) => printers.doc(id).delete();

  Stream<List<FilamentSpool>> watchFilaments() =>
      _watch(filaments, FilamentSpool.fromJson);

  Future<void> saveFilament(FilamentSpool spool) {
    return filaments.doc(spool.id).set(spool.toJson());
  }

  Future<void> deleteFilament(String id) => filaments.doc(id).delete();

  Stream<List<Customer>> watchCustomers() =>
      _watch(customers, Customer.fromJson);

  Future<void> saveCustomer(Customer customer) {
    return customers.doc(customer.id).set(customer.toJson());
  }

  Future<void> deleteCustomer(String id) => customers.doc(id).delete();

  Stream<List<PrintOrder>> watchOrders() => _watch(orders, PrintOrder.fromJson);

  Stream<List<CatalogProduct>> watchProducts() =>
      _watch(products, CatalogProduct.fromJson);

  Future<void> saveProduct(CatalogProduct product) {
    return products.doc(product.id).set(product.toJson());
  }

  Future<void> deleteProduct(String id) => products.doc(id).delete();

  Future<void> saveOrder(PrintOrder order) {
    return orders.doc(order.id).set(order.toJson());
  }

  /// Links a customer without rewriting status, stock, or the prints.
  Future<void> updateOrderCustomer({
    required String orderId,
    required String customerId,
  }) {
    return _updateOrderFields(orderId, {'customerId': customerId});
  }

  /// Replaces the prints on an order that has not taken filament.
  ///
  /// The document is read inside the transaction. A stale screen copy
  /// cannot clear [PrintOrder.stockDeducted] or put grams back. Throws
  /// [OrderPrintsLocked] when stock was already taken.
  Future<void> replaceOrderPrints({
    required String orderId,
    required List<QuoteLine> lines,
    required String title,
  }) {
    if (lines.isEmpty) {
      return Future.value();
    }
    final ref = orders.doc(orderId);
    return db.runTransaction((transaction) async {
      final snapshot = await transaction.get(ref);
      if (!snapshot.exists || snapshot.data() == null) {
        return;
      }
      final current = PrintOrder.fromJson({
        ...snapshot.data()!,
        'id': orderId,
      });
      if (current.stockDeducted) {
        throw const OrderPrintsLocked();
      }
      final updated = orderWithPrints(current, lines).copyWith(
        title: title,
        updatedAt: DateTime.now().toUtc().toIso8601String(),
      );
      final payload = updated.toJson()
        ..remove('id')
        ..remove('quoteNumber')
        ..remove('customerId')
        ..remove('status')
        ..remove('validUntil')
        ..remove('currencyCode')
        ..remove('quoteLanguage')
        ..remove('stockDeducted')
        ..remove('deductedGrams')
        ..remove('stockWarning')
        ..remove('depositMinor')
        ..remove('depositAt')
        ..remove('revenueAt')
        ..remove('note')
        ..remove('createdAt');
      transaction.update(ref, payload);
    });
  }

  /// Updates the note only. A full [saveOrder] of a screen snapshot can
  /// overwrite a status change that already moved filament stock.
  Future<void> saveOrderNote({required String orderId, required String note}) {
    return _updateOrderFields(orderId, {'note': note});
  }

  /// Updates the title only, for the same reason as [saveOrderNote].
  Future<void> saveOrderTitle({
    required String orderId,
    required String title,
  }) {
    return _updateOrderFields(orderId, {'title': title});
  }

  /// Records a deposit without rewriting status or stock fields.
  ///
  /// [depositAt] is the receipt date. An empty string clears it, which is
  /// what a zero deposit does.
  Future<void> saveOrderDeposit({
    required String orderId,
    required int depositMinor,
    required String depositAt,
  }) {
    final amount = depositMinor < 0 ? 0 : depositMinor;
    return _updateOrderFields(orderId, {
      'depositMinor': amount,
      'depositAt': amount == 0 ? '' : depositAt,
    });
  }

  /// Writes a catalog id onto one print without rewriting status or stock.
  Future<void> stampLineProductId({
    required String orderId,
    required String lineId,
    required String productId,
  }) {
    final ref = orders.doc(orderId);
    return db.runTransaction((transaction) async {
      final snapshot = await transaction.get(ref);
      if (!snapshot.exists) {
        return;
      }
      final raw = snapshot.data();
      if (raw == null) {
        return;
      }
      final order = PrintOrder.fromJson({...raw, 'id': orderId});
      final prints = orderPrints(order);
      var found = false;
      final next = <QuoteLine>[];
      for (final line in prints) {
        if (line.id == lineId) {
          found = true;
          next.add(line.copyWith(productId: productId));
        } else {
          next.add(line);
        }
      }
      if (!found) {
        return;
      }
      final updated = orderWithPrints(order, next);
      transaction.update(ref, {
        'lines': [
          for (final line in updated.lines) line.toJson(),
        ],
        'updatedAt': DateTime.now().toUtc().toIso8601String(),
      });
    });
  }

  Future<void> _updateOrderFields(String orderId, Map<String, Object?> fields) {
    final ref = orders.doc(orderId);
    return db.runTransaction((transaction) async {
      final snapshot = await transaction.get(ref);
      if (!snapshot.exists) {
        return;
      }
      transaction.update(ref, {
        ...fields,
        'updatedAt': DateTime.now().toUtc().toIso8601String(),
      });
    });
  }

  Future<void> deleteInboxItem(String id) => inbox.doc(id).delete();

  Future<WorkshopBackup> loadWorkshopBackup() async {
    final settingsSnap = await settingsDoc.get();
    final settings = settingsSnap.exists && settingsSnap.data() != null
        ? WorkshopSettings.fromJson(settingsSnap.data()!)
        : const WorkshopSettings();
    return WorkshopBackup(
      settings: settings,
      printers: await _loadAll(printers, PrinterProfile.fromJson),
      filaments: await _loadAll(filaments, FilamentSpool.fromJson),
      customers: await _loadAll(customers, Customer.fromJson),
      orders: await _loadAll(orders, PrintOrder.fromJson),
      products: await _loadAll(products, CatalogProduct.fromJson),
      exportedAt: DateTime.now().toUtc().toIso8601String(),
    );
  }

  /// Applies a merge plan. Documents that are not in the plan stay.
  Future<void> applyWorkshopImport(WorkshopImportPlan plan) async {
    await settingsDoc.set(plan.settings.toJson(), SetOptions(merge: true));
    for (final printer in plan.printers) {
      await savePrinter(printer);
    }
    for (final spool in plan.filaments) {
      await saveFilament(spool);
    }
    for (final customer in plan.customers) {
      await saveCustomer(customer);
    }
    for (final order in plan.orders) {
      await saveOrder(order);
    }
    for (final product in plan.products) {
      await saveProduct(product);
    }
  }

  Future<List<T>> _loadAll<T>(
    CollectionReference<Map<String, dynamic>> collection,
    T Function(Map<String, dynamic> json) decode,
  ) async {
    final snapshot = await collection.get();
    final items = <T>[];
    for (final doc in snapshot.docs) {
      try {
        items.add(decode({...doc.data(), 'id': doc.id}));
      } on Object {
        // Skip a document the app can no longer read.
      }
    }
    return items;
  }

  Future<void> deleteOwnedData({required String? email}) async {
    for (final collection in [
      printers,
      filaments,
      customers,
      orders,
      products,
      inbox,
    ]) {
      await _deleteCollection(collection);
    }
    await settingsDoc.delete();
    await db.collection('users').doc(uid).delete();
    final key = email?.trim().toLowerCase() ?? '';
    if (key.isEmpty) {
      return;
    }
    final entry = await directory.doc(key).get();
    if (entry.data()?['uid'] == uid) {
      await entry.reference.delete();
    }
  }

  Future<void> _deleteCollection(
    CollectionReference<Map<String, dynamic>> collection,
  ) async {
    final snapshot = await collection.get();
    var batch = db.batch();
    var count = 0;
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
      count++;
      if (count == 400) {
        await batch.commit();
        batch = db.batch();
        count = 0;
      }
    }
    if (count > 0) {
      await batch.commit();
    }
  }

  Future<void> ensureDirectory({
    required String email,
    required String displayName,
  }) {
    final key = email.trim().toLowerCase();
    if (key.isEmpty) {
      return Future.value();
    }
    // uid and display name only. The email is the document id, not a field.
    return directory.doc(key).set(
      directoryEntryData(uid: uid, displayName: displayName),
    );
  }

  Future<DirectoryEntry?> findUserByEmail(String email) async {
    final key = email.trim().toLowerCase();
    final snapshot = await directory.doc(key).get();
    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }
    final data = snapshot.data()!;
    final foundUid = data['uid'] as String?;
    if (foundUid == null || foundUid.isEmpty) {
      return null;
    }
    return DirectoryEntry(
      uid: foundUid,
      email: key,
      displayName: (data['displayName'] as String?) ?? key,
    );
  }

  Future<void> sendToUser({
    required String recipientUid,
    required SharedItemType type,
    required Map<String, dynamic> payload,
    required String senderName,
    required String senderEmail,
  }) async {
    final payloadJson = jsonEncode(payload);
    if (payloadJson.length > inboxPayloadMaxChars) {
      throw const InboxPayloadTooLarge();
    }
    final doc = db
        .collection('users')
        .doc(recipientUid)
        .collection('inbox')
        .doc();
    // createdAt has to be the server time. senderEmail has to be the
    // Firebase Auth email, not a lowercased copy.
    await doc.set({
      'type': type.name,
      'payloadJson': payloadJson,
      'senderUid': uid,
      'senderName': _bounded(senderName, inboxSenderNameMax),
      'senderEmail': senderEmail,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<InboxItem>> watchInbox() {
    return inbox.snapshots().map((snapshot) {
      final items = <InboxItem>[];
      for (final doc in snapshot.docs) {
        try {
          final data = doc.data();
          items.add(
            InboxItem.fromJson({
              ...data,
              'id': doc.id,
              'createdAt': inboxCreatedAtText(data['createdAt']),
            }),
          );
        } on Object {
          // Skip a document the app can no longer read.
        }
      }
      return items;
    });
  }

  Stream<List<T>> _watch<T>(
    CollectionReference<Map<String, dynamic>> collection,
    T Function(Map<String, dynamic> json) decode,
  ) {
    return collection.snapshots().map((snapshot) {
      final items = <T>[];
      for (final doc in snapshot.docs) {
        try {
          items.add(decode({...doc.data(), 'id': doc.id}));
        } on Object {
          // Skip a document the app can no longer read.
        }
      }
      return items;
    });
  }
}

class DirectoryEntry {
  const DirectoryEntry({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  final String uid;
  final String email;
  final String displayName;
}

/// Same caps as firestore.rules.
const directoryDisplayNameMax = 320;
const inboxSenderNameMax = 320;
const inboxPayloadMaxChars = 100000;

/// Directory rows store the uid and a display name. The email is the id.
Map<String, String> directoryEntryData({
  required String uid,
  required String displayName,
}) {
  return {
    'uid': uid,
    'displayName': _bounded(displayName, directoryDisplayNameMax),
  };
}

String _bounded(String value, int max) {
  final trimmed = value.trim();
  if (trimmed.length <= max) {
    return trimmed;
  }
  return trimmed.substring(0, max);
}

/// Inbox writes use a server timestamp. Older items stored an ISO-8601 string.
String inboxCreatedAtText(Object? value) {
  if (value is Timestamp) {
    return value.toDate().toUtc().toIso8601String();
  }
  if (value is String) {
    return value;
  }
  return '';
}

class InboxPayloadTooLarge implements Exception {
  const InboxPayloadTooLarge();
}

/// The order already took filament, so its prints cannot be replaced.
class OrderPrintsLocked implements Exception {
  const OrderPrintsLocked();
}

/// Settings written by the workshop screen. The quote counter is omitted.
Map<String, dynamic> settingsWithoutQuoteCounter(WorkshopSettings settings) {
  final data = settings.toJson();
  data.remove('nextQuoteNumber');
  return data;
}
