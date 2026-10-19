import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../core/money.dart';
import '../../../core/text_prompt.dart';
import '../../../core/user_store.dart';
import '../../catalog/domain/catalog_product.dart';
import '../../catalog/presentation/product_picker.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../orders/data/order_stock.dart';
import '../../orders/domain/duplicate_quote.dart';
import '../../orders/domain/print_order.dart';
import '../../pricing/domain/live_quote.dart';
import '../../printers/domain/printer_profile.dart';
import '../../settings/domain/workshop_settings.dart';

Future<String?> duplicateQuoteAsNew({
  required BuildContext context,
  required UserStore store,
  required PrintOrder order,
  required WorkshopSettings settings,
  required List<FilamentSpool> spools,
  required List<PrinterProfile> printers,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Duplicate as new quote'),
      content: const Text(duplicateQuoteExplanation),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Create quote'),
        ),
      ],
    ),
  );
  if (confirmed != true) {
    return null;
  }
  final number = await OrderStock(store).allocateQuoteNumber();
  final duplicated = duplicateAsNewQuote(
    source: order,
    id: const Uuid().v4(),
    quoteNumber: number,
    now: DateTime.now().toUtc(),
    settings: settings,
    spools: spools,
    printers: printers,
    newLineId: () => const Uuid().v4(),
  );
  await store.saveOrder(duplicated.order);
  if (context.mounted) {
    final warning = duplicated.warnings.isEmpty
        ? ''
        : ' ${duplicated.warnings.join(' ')}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Created quote $number. Prices were recalculated from current spools, the printer, and workshop rates. Stock was not copied.$warning',
        ),
      ),
    );
  }
  return duplicated.order.id;
}

Future<void> addProductToQuote({
  required BuildContext context,
  required UserStore store,
  required PrintOrder order,
  required List<CatalogProduct> products,
  required WorkshopSettings settings,
  required List<FilamentSpool> spools,
  required List<PrinterProfile> printers,
}) async {
  if (order.stockDeducted) {
    return;
  }
  if (products.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No saved products yet. Save one from a print first.'),
      ),
    );
    return;
  }
  final product = await pickCatalogProduct(context, products);
  if (product == null || !context.mounted) {
    return;
  }
  final raw = await promptForText(
    context,
    title: product.name,
    label: 'Quantity',
    initialText: '1',
    confirmLabel: 'Add',
    keyboardType: TextInputType.number,
  );
  final quantity = parsePositiveInt(raw ?? '') ?? 0;
  if (quantity < 1 || !context.mounted) {
    return;
  }
  final priced = priceProduct(
    product: product,
    lineId: const Uuid().v4(),
    quantity: quantity,
    settings: settings,
    spools: spools,
    printers: printers,
  );
  final next = [...orderPrints(order), priced.line];
  await store.saveOrder(
    orderWithPrints(order, next).copyWith(
      title: quoteTitleFor(order, next),
      updatedAt: DateTime.now().toUtc().toIso8601String(),
    ),
  );
  if (context.mounted) {
    final warning = priced.warnings.isEmpty
        ? ''
        : ' ${priced.warnings.join(' ')}';
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$productPriceExplanation$warning')));
  }
}

Future<void> saveLineAsProduct({
  required BuildContext context,
  required UserStore store,
  required PrintOrder order,
  required QuoteLine line,
}) async {
  final now = DateTime.now().toUtc();
  final existing = line.productId.trim();
  final product = productFromLine(
    line,
    id: existing.isEmpty ? const Uuid().v4() : existing,
    now: now,
  );
  await store.saveProduct(product);
  if (existing.isEmpty) {
    await store.stampLineProductId(
      orderId: order.id,
      lineId: line.id,
      productId: product.id,
    );
  }
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Saved “${product.name}” to products. $productPriceExplanation',
        ),
      ),
    );
  }
}
