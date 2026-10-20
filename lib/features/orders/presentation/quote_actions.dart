import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../core/money.dart';
import '../../../core/save_feedback.dart';
import '../../../core/text_prompt.dart';
import '../../../core/user_store.dart';
import '../../../l10n/l10n.dart';
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
  final l10n = context.l10n;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.orderDuplicateAction),
      content: Text(duplicateQuoteExplanation(l10n)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.orderCreateQuote),
        ),
      ],
    ),
  );
  if (confirmed != true) {
    return null;
  }
  final int number;
  try {
    number = await OrderStock(store).allocateQuoteNumber();
  } on Object {
    if (context.mounted) {
      showSaveError(context, context.l10n.quoteNumberFailed);
    }
    return null;
  }
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
      SnackBar(content: Text(context.l10n.orderCreatedQuote(number, warning))),
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
  final l10n = context.l10n;
  if (order.stockDeducted) {
    showSaveError(context, l10n.calcPrintsLocked);
    return;
  }
  if (products.isEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.orderNoProducts)));
    return;
  }
  final product = await pickCatalogProduct(context, products);
  if (product == null || !context.mounted) {
    return;
  }
  final raw = await promptForText(
    context,
    title: product.name,
    label: context.l10n.fieldQuantity,
    initialText: '1',
    confirmLabel: context.l10n.orderAdd,
    keyboardType: TextInputType.number,
  );
  final quantity = parsePositiveInt(raw ?? '') ?? 0;
  if (quantity < 1 || !context.mounted) {
    return;
  }
  final priced = priceProduct(
    l10n: context.l10n,
    product: product,
    lineId: const Uuid().v4(),
    quantity: quantity,
    settings: settings,
    spools: spools,
    printers: printers,
  );
  final next = [...orderPrints(order), priced.line];
  try {
    await store.replaceOrderPrints(
      orderId: order.id,
      lines: next,
      title: quoteTitleFor(order, next),
    );
  } on OrderPrintsLocked {
    if (context.mounted) {
      showSaveError(context, context.l10n.calcPrintsLocked);
    }
    return;
  } on Object {
    if (context.mounted) {
      showSaveError(context, context.l10n.calcSavePrintFailed);
    }
    return;
  }
  if (context.mounted) {
    final warning = priced.warnings.isEmpty
        ? ''
        : ' ${priced.warnings.join(' ')}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${productPriceExplanation(l10n: context.l10n)}$warning'),
      ),
    );
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
          context.l10n.orderSavedProduct(
            product.name,
            productPriceExplanation(l10n: context.l10n),
          ),
        ),
      ),
    );
  }
}
