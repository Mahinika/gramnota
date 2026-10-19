import 'package:flutter/material.dart';

import '../../../core/format.dart';
import '../../../l10n/l10n.dart';
import '../domain/catalog_product.dart';

Future<CatalogProduct?> pickCatalogProduct(
  BuildContext context,
  List<CatalogProduct> products,
) {
  final sorted = [...products]
    ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  return showModalBottomSheet<CatalogProduct>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      final l10n = context.l10n;
      return SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                l10n.productAddProduct,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            for (final product in sorted)
              ListTile(
                title: Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  productSummary(product, l10n: l10n),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => Navigator.pop(context, product),
              ),
          ],
        ),
      );
    },
  );
}

String productSummary(
  CatalogProduct product, {
  required AppLocalizations l10n,
}) {
  final grams = product.filaments.fold<double>(
    0,
    (sum, filament) => sum + filament.grams,
  );
  final parts = <String>[
    if (product.printTimeSeconds > 0) formatDuration(product.printTimeSeconds),
    if (grams > 0) formatGrams(grams, locale: l10n.localeName),
  ];
  if (parts.isEmpty) {
    return l10n.productNoPrintTime;
  }
  return parts.join(' · ');
}
