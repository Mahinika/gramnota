import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/format.dart';
import '../../customers/domain/customer.dart';
import '../../settings/domain/workshop_settings.dart';
import '../domain/print_order.dart';

Future<Uint8List> buildQuotePdf({
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
              pw.Text(formatMoney(line.breakdown.totalMinor, currency)),
            ],
          ),
          pw.SizedBox(height: 8),
        ],
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('VAT'),
            pw.Text(formatMoney(order.breakdown.vatMinor, currency)),
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
  return doc.save();
}

Future<void> shareQuotePdf({
  required PrintOrder order,
  required WorkshopSettings settings,
  required Customer? customer,
}) async {
  final bytes = await buildQuotePdf(
    order: order,
    settings: settings,
    customer: customer,
  );
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

void openQuotePdfPreview(
  BuildContext context, {
  required PrintOrder order,
  required WorkshopSettings settings,
  required Customer? customer,
}) {
  Navigator.of(context, rootNavigator: true).push(
    MaterialPageRoute<void>(
      builder: (_) => QuotePdfPreviewScreen(
        order: order,
        settings: settings,
        customer: customer,
      ),
    ),
  );
}

class QuotePdfPreviewScreen extends StatefulWidget {
  const QuotePdfPreviewScreen({
    required this.order,
    required this.settings,
    required this.customer,
    super.key,
  });

  final PrintOrder order;
  final WorkshopSettings settings;
  final Customer? customer;

  @override
  State<QuotePdfPreviewScreen> createState() => _QuotePdfPreviewScreenState();
}

class _QuotePdfPreviewScreenState extends State<QuotePdfPreviewScreen> {
  var _sharing = false;

  Future<void> _share() async {
    setState(() => _sharing = true);
    try {
      await shareQuotePdf(
        order: widget.order,
        settings: widget.settings,
        customer: widget.customer,
      );
    } finally {
      if (mounted) {
        setState(() => _sharing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote ${widget.order.quoteNumber}'),
        actions: [
          IconButton(
            tooltip: 'Share quote',
            onPressed: _sharing ? null : _share,
            icon: _sharing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.ios_share),
          ),
        ],
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        padding: const EdgeInsets.all(16),
        initialPageFormat: PdfPageFormat.a4,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        allowPrinting: false,
        allowSharing: false,
        useActions: false,
        pdfFileName: 'quote-${widget.order.quoteNumber}.pdf',
        loadingWidget: const Center(child: CircularProgressIndicator()),
        build: (format) => buildQuotePdf(
          order: widget.order,
          settings: widget.settings,
          customer: widget.customer,
        ),
      ),
    );
  }
}
