import 'package:flutter/material.dart';

import '../../../core/format.dart';
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
      return SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                'Add a product',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            for (final product in sorted)
              ListTile(
                title: Text(product.name),
                subtitle: Text(productSummary(product)),
                onTap: () => Navigator.pop(context, product),
              ),
          ],
        ),
      );
    },
  );
}

String productSummary(CatalogProduct product) {
  final grams = product.filaments.fold<double>(
    0,
    (sum, filament) => sum + filament.grams,
  );
  final parts = <String>[
    if (product.printTimeSeconds > 0) formatDuration(product.printTimeSeconds),
    if (grams > 0) formatGrams(grams),
  ];
  if (parts.isEmpty) {
    return 'No print time yet';
  }
  return parts.join(' · ');
}
