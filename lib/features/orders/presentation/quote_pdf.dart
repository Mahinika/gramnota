import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../../core/format.dart';
import '../../customers/domain/customer.dart';
import '../../settings/domain/workshop_settings.dart';
import '../domain/print_order.dart';

Future<void> shareQuotePdf({
  required PrintOrder order,
  required WorkshopSettings settings,
  required Customer? customer,
}) async {
  final currency = order.currencyCode;
  final prints = orderPrints(order);
  final regular = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
  );
  final bold = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'),
  );
  final doc = pw.Document(
    theme: pw.ThemeData.withFont(base: regular, bold: bold),
  );
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        pw.Text(
          settings.businessName.isEmpty ? 'Quote' : settings.businessName,
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          [
            settings.street,
            '${settings.postalCode} ${settings.city}'.trim(),
            settings.orgNumber.isEmpty ? '' : 'Org. no. ${settings.orgNumber}',
            settings.phone,
            settings.email,
          ].where((line) => line.trim().isNotEmpty).join('\n'),
        ),
        pw.SizedBox(height: 16),
        pw.Text('Quote ${order.quoteNumber}'),
        pw.Text(order.title),
        if (order.validUntil.isNotEmpty)
          pw.Text('Valid until ${order.validUntil.substring(0, 10)}'),
        if (customer != null) ...[
          pw.SizedBox(height: 8),
          pw.Text(customer.name),
          pw.Text(customer.addressLine),
          if (customer.phone.isNotEmpty) pw.Text(customer.phone),
        ],
        pw.SizedBox(height: 16),
        for (final line in prints) ...[
          pw.Text(
            line.title,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.Text('Quantity ${line.quantity}'),
          pw.Text('Print time ${formatDuration(line.printTimeSeconds)}'),
          if (line.sourceProfileTitle.isNotEmpty)
            pw.Text(line.sourceProfileTitle),
          pw.Text(formatMoney(line.breakdown.totalMinor, currency)),
          pw.SizedBox(height: 8),
        ],
        pw.SizedBox(height: 8),
        for (final row in [
          ('Material', order.breakdown.materialMinor),
          ('Electricity', order.breakdown.electricityMinor),
          ('Machine wear', order.breakdown.machineMinor),
          ('Failure buffer', order.breakdown.failureMinor),
          ('Labor', order.breakdown.laborMinor),
          ('Extras', order.breakdown.extrasMinor),
          ('Cost', order.breakdown.costMinor),
          ('Markup', order.breakdown.markupMinor),
          ('Net', order.breakdown.netMinor),
          ('VAT', order.breakdown.vatMinor),
        ])
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(row.$1),
              pw.Text(formatMoney(row.$2, currency)),
            ],
          ),
        pw.Divider(),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Total',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              formatMoney(order.breakdown.totalMinor, currency),
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
        if (prints.length == 1)
          pw.Text(
            '${formatMoney(prints.single.breakdown.perUnitMinor, currency)} per unit',
          ),
      ],
    ),
  );
  final bytes = await doc.save();
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/quote-${order.quoteNumber}.pdf');
  await file.writeAsBytes(bytes, flush: true);
  await SharePlus.instance.share(
    ShareParams(
      files: [XFile(file.path)],
      subject: 'Quote ${order.quoteNumber}',
    ),
  );
}
