import 'dart:convert';

import '../../catalog/domain/catalog_product.dart';
import '../../customers/domain/customer.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../orders/domain/print_order.dart';
import '../../printers/domain/printer_profile.dart';
import 'workshop_settings.dart';

/// One JSON file with the workshop collections the seller owns.
class WorkshopBackup {
  const WorkshopBackup({
    required this.settings,
    required this.printers,
    required this.filaments,
    required this.customers,
    required this.orders,
    required this.products,
    this.exportedAt = '',
  });

  static const formatId = 'gramnota-workshop';
  static const formatVersion = 1;

  final WorkshopSettings settings;
  final List<PrinterProfile> printers;
  final List<FilamentSpool> filaments;
  final List<Customer> customers;
  final List<PrintOrder> orders;
  final List<CatalogProduct> products;
  final String exportedAt;

  Map<String, dynamic> toJson() {
    return {
      'format': formatId,
      'version': formatVersion,
      if (exportedAt.isNotEmpty) 'exportedAt': exportedAt,
      'settings': settings.toJson(),
      'printers': [for (final item in printers) item.toJson()],
      'filaments': [for (final item in filaments) item.toJson()],
      'customers': [for (final item in customers) item.toJson()],
      'orders': [for (final item in orders) item.toJson()],
      'products': [for (final item in products) item.toJson()],
    };
  }

  String encode() => jsonEncode(toJson());

  factory WorkshopBackup.decode(String source) {
    final raw = jsonDecode(source);
    if (raw is! Map) {
      throw const FormatException('Backup is not an object.');
    }
    return WorkshopBackup.fromJson(Map<String, dynamic>.from(raw));
  }

  factory WorkshopBackup.fromJson(Map<String, dynamic> json) {
    if (json['format'] != formatId) {
      throw const FormatException('Not a Gramnota workshop backup.');
    }
    final version = json['version'];
    if (version is! int || version < 1) {
      throw const FormatException('Unsupported backup version.');
    }
    final settingsRaw = json['settings'];
    if (settingsRaw is! Map) {
      throw const FormatException('Backup is missing settings.');
    }
    return WorkshopBackup(
      settings: WorkshopSettings.fromJson(
        Map<String, dynamic>.from(settingsRaw),
      ),
      printers: _decodeList(json['printers'], PrinterProfile.fromJson),
      filaments: _decodeList(json['filaments'], FilamentSpool.fromJson),
      customers: _decodeList(json['customers'], Customer.fromJson),
      orders: _decodeList(json['orders'], PrintOrder.fromJson),
      products: _decodeList(json['products'], CatalogProduct.fromJson),
      exportedAt: json['exportedAt'] is String ? json['exportedAt'] as String : '',
    );
  }
}

/// What an import should write. Documents that are not listed stay.
class WorkshopImportPlan {
  const WorkshopImportPlan({
    required this.settings,
    required this.printers,
    required this.filaments,
    required this.customers,
    required this.orders,
    required this.products,
  });

  final WorkshopSettings settings;
  final List<PrinterProfile> printers;
  final List<FilamentSpool> filaments;
  final List<Customer> customers;
  final List<PrintOrder> orders;
  final List<CatalogProduct> products;
}

/// Merge [incoming] into the workshop that is already saved.
///
/// Missing local records stay. The next quote number becomes the higher of
/// the two counters. A local order that already took filament is left as it
/// is. A local spool keeps the grams that are on it now.
WorkshopImportPlan planWorkshopImport({
  required WorkshopBackup incoming,
  WorkshopSettings? localSettings,
  Map<String, FilamentSpool> localFilaments = const {},
  Map<String, PrintOrder> localOrders = const {},
}) {
  final localNext = localSettings == null || localSettings.nextQuoteNumber < 1
      ? 1
      : localSettings.nextQuoteNumber;
  final incomingNext = incoming.settings.nextQuoteNumber < 1
      ? 1
      : incoming.settings.nextQuoteNumber;
  final nextQuote = localNext > incomingNext ? localNext : incomingNext;
  final filaments = <FilamentSpool>[];
  for (final spool in incoming.filaments) {
    final local = localFilaments[spool.id];
    if (local == null) {
      filaments.add(spool);
    } else {
      filaments.add(spool.copyWith(remainingGrams: local.remainingGrams));
    }
  }
  final orders = <PrintOrder>[
    for (final order in incoming.orders)
      if (localOrders[order.id]?.stockDeducted != true) order,
  ];
  return WorkshopImportPlan(
    settings: incoming.settings.copyWith(nextQuoteNumber: nextQuote),
    printers: incoming.printers,
    filaments: filaments,
    customers: incoming.customers,
    orders: orders,
    products: incoming.products,
  );
}

List<T> _decodeList<T>(
  Object? raw,
  T Function(Map<String, dynamic> json) decode,
) {
  if (raw is! List) {
    return const [];
  }
  final items = <T>[];
  for (final entry in raw) {
    if (entry is! Map) {
      continue;
    }
    try {
      items.add(decode(Map<String, dynamic>.from(entry)));
    } on Object {
      // Skip one record the app can no longer read.
    }
  }
  return items;
}
