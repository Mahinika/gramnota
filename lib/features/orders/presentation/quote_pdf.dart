import 'package:flutter/services.dart';
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
          pw.Text('Valid until ${_quoteDate(order.validUntil)}'),
        if (customer != null) ...[
          pw.SizedBox(height: 8),
          pw.Text(customer.name),
          pw.Text(customer.addressLine),
          if (customer.phone.isNotEmpty) pw.Text(customer.phone),
        ],
        pw.SizedBox(height: 16),
        pw.Text('Prices exclude VAT.'),
        pw.SizedBox(height: 8),
        for (final line in prints) ...[
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      line.title,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text('Quantity ${line.quantity}'),
                    if (line.sourceProfileTitle.isNotEmpty)
                      pw.Text(line.sourceProfileTitle),
                  ],
                ),
              ),
              pw.Text(formatMoney(line.breakdown.netMinor, currency)),
            ],
          ),
          pw.SizedBox(height: 8),
        ],
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Price ex. VAT'),
            pw.Text(formatMoney(order.breakdown.netMinor, currency)),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('VAT'),
            pw.Text(formatMoney(order.breakdown.vatMinor, currency)),
          ],
        ),
        pw.Text('VAT is included in the total.'),
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
            '${formatMoney(prints.single.breakdown.perUnitMinor, currency)} per unit, incl. VAT',
          ),
      ],
    ),
  );
  final bytes = await doc.save();
  await SharePlus.instance.share(
    ShareParams(
      files: [
        XFile.fromData(
          bytes,
          mimeType: 'application/pdf',
          name: 'quote-${order.quoteNumber}.pdf',
        ),
      ],
      subject: 'Quote ${order.quoteNumber}',
    ),
  );
}

String _quoteDate(String iso) {
  final parsed = DateTime.tryParse(iso);
  if (parsed == null) {
    return iso.length >= 10 ? iso.substring(0, 10) : iso;
  }
  final local = parsed.toLocal();
  final month = local.month.toString().padLeft(2, '0');
  final day = local.day.toString().padLeft(2, '0');
  return '${local.year}-$month-$day';
}
