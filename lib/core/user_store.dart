import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../features/catalog/domain/catalog_product.dart';
import '../features/customers/domain/customer.dart';
import '../features/filaments/domain/filament_spool.dart';
import '../features/orders/domain/print_order.dart';
import '../features/printers/domain/printer_profile.dart';
import '../features/settings/domain/workshop_settings.dart';
import '../features/sharing/domain/inbox_item.dart';

class UserStore {
  UserStore(this.db, this.uid);

  final FirebaseFirestore db;
  final String uid;

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
      if (!snapshot.exists || snapshot.data() == null) {
        // No document yet, so the workshop setup still has to run.
        return const WorkshopSettings();
      }
      return WorkshopSettings.fromJson(snapshot.data()!);
    });
  }

  Future<void> saveSettings(WorkshopSettings settings) {
    return settingsDoc.set(settings.toJson());
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

  Stream<List<InboxItem>> watchInbox() => _watch(inbox, InboxItem.fromJson);

  Future<void> deleteInboxItem(String id) => inbox.doc(id).delete();

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
    return directory.doc(key).set({
      'uid': uid,
      'displayName': displayName,
      'email': key,
    });
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
  }) {
    final doc = db
        .collection('users')
        .doc(recipientUid)
        .collection('inbox')
        .doc();
    return doc.set(
      InboxItem(
        id: doc.id,
        type: type,
        payloadJson: jsonEncode(payload),
        senderUid: uid,
        senderName: senderName,
        senderEmail: senderEmail,
        createdAt: DateTime.now().toUtc().toIso8601String(),
      ).toJson(),
    );
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
