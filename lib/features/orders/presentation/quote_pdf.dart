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
  const ink = PdfColor.fromInt(0xFF1A1F1C);
  const muted = PdfColor.fromInt(0xFF5E6963);
  const line = PdfColor.fromInt(0xFFD9E0DC);
  const wash = PdfColor.fromInt(0xFFF3F7F5);
  const brand = PdfColor.fromInt(0xFF0F6E56);
  final label = pw.TextStyle(
    fontSize: 8,
    letterSpacing: 0.8,
    color: brand,
    fontWeight: pw.FontWeight.bold,
  );
  final body = pw.TextStyle(fontSize: 10, height: 1.35, color: ink);
  final quiet = pw.TextStyle(fontSize: 9, height: 1.3, color: muted);
  final seller = _filledLines([
    settings.businessName,
    settings.street,
    '${settings.postalCode} ${settings.city}'.trim(),
    if (settings.orgNumber.trim().isNotEmpty)
      'Org. no. ${settings.orgNumber.trim()}',
    settings.phone,
    settings.email,
  ]);
  final buyer = customer == null
      ? const <String>[]
      : _filledLines([
          customer.name,
          customer.street,
          '${customer.postalCode} ${customer.city}'.trim(),
          customer.country,
          customer.phone,
          customer.email,
        ]);
  final issued = formatIsoDate(order.createdAt);
  final valid = formatIsoDate(order.validUntil);
  final vatLabel = _vatLabel(prints);

  pw.Widget party(String title, List<String> lines) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: label),
        pw.SizedBox(height: 6),
        pw.Text(
          lines.isEmpty ? 'Not specified' : lines.join('\n'),
          style: lines.isEmpty ? quiet : body,
        ),
      ],
    );
  }

  pw.Widget meta(String title, String value) {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title, style: label),
          pw.SizedBox(height: 3),
          pw.Text(
            value.isEmpty ? '—' : value,
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
              color: ink,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget cell(
    String text, {
    bool header = false,
    pw.Alignment align = pw.Alignment.centerLeft,
    bool strong = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: pw.Align(
        alignment: align,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: header ? 8 : 10,
            color: header ? PdfColors.white : ink,
            fontWeight: header || strong
                ? pw.FontWeight.bold
                : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }

  final doc = pw.Document(
    theme: pw.ThemeData.withFont(base: regular, bold: bold),
  );
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.fromLTRB(36, 32, 36, 46),
      footer: (context) => pw.Column(
        children: [
          pw.Container(height: 0.6, color: line),
          pw.SizedBox(height: 8),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  _filledLines([
                    settings.businessName,
                    settings.email,
                    settings.phone,
                  ]).join('   ·   '),
                  style: pw.TextStyle(fontSize: 8, color: muted),
                ),
              ),
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount}',
                style: pw.TextStyle(fontSize: 8, color: muted),
              ),
            ],
          ),
        ],
      ),
      build: (context) => [
        pw.Container(height: 4, color: brand),
        pw.SizedBox(height: 18),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Text(
                settings.businessName.trim().isEmpty
                    ? 'Quote'
                    : settings.businessName.trim(),
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: ink,
                ),
              ),
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text('QUOTE', style: label),
                pw.SizedBox(height: 2),
                pw.Text(
                  '${order.quoteNumber}',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: ink,
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 16),
        pw.Container(
          color: wash,
          padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: pw.Row(
            children: [
              meta('Quote no.', '${order.quoteNumber}'),
              meta('Issued', issued),
              meta('Valid until', valid),
            ],
          ),
        ),
        pw.SizedBox(height: 18),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(child: party('From', seller)),
            pw.SizedBox(width: 28),
            pw.Expanded(child: party('Bill to', buyer)),
          ],
        ),
        pw.SizedBox(height: 22),
        pw.Text(
          order.title,
          style: pw.TextStyle(
            fontSize: 13,
            fontWeight: pw.FontWeight.bold,
            color: ink,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Table(
          border: pw.TableBorder(
            bottom: const pw.BorderSide(color: line, width: 0.6),
            horizontalInside: const pw.BorderSide(color: line, width: 0.4),
          ),
          columnWidths: const {
            0: pw.FlexColumnWidth(4.2),
            1: pw.FlexColumnWidth(1),
            2: pw.FlexColumnWidth(1.7),
            3: pw.FlexColumnWidth(1.7),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: brand),
              children: [
                cell('Description', header: true),
                cell('Qty', header: true, align: pw.Alignment.center),
                cell(
                  'Unit price',
                  header: true,
                  align: pw.Alignment.centerRight,
                ),
                cell('Amount', header: true, align: pw.Alignment.centerRight),
              ],
            ),
            for (var index = 0; index < prints.length; index++)
              pw.TableRow(
                decoration: pw.BoxDecoration(
                  color: index.isOdd ? wash : PdfColors.white,
                ),
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          prints[index].title,
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: ink,
                          ),
                        ),
                        if (_lineDetail(prints[index]).isNotEmpty) ...[
                          pw.SizedBox(height: 2),
                          pw.Text(_lineDetail(prints[index]), style: quiet),
                        ],
                      ],
                    ),
                  ),
                  cell('${prints[index].quantity}', align: pw.Alignment.center),
                  cell(
                    formatMoney(_unitNet(prints[index]), currency),
                    align: pw.Alignment.centerRight,
                  ),
                  cell(
                    formatMoney(prints[index].breakdown.netMinor, currency),
                    align: pw.Alignment.centerRight,
                    strong: true,
                  ),
                ],
              ),
          ],
        ),
        pw.SizedBox(height: 6),
        pw.Text(
          'Line amounts exclude VAT. VAT is included in the total.',
          style: quiet,
        ),
        pw.SizedBox(height: 14),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Container(
            width: 230,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: line, width: 0.6),
            ),
            child: pw.Column(
              children: [
                _sumRow(
                  'Subtotal',
                  formatMoney(order.breakdown.netMinor, currency),
                  ink: ink,
                  muted: muted,
                ),
                _sumRow(
                  vatLabel,
                  formatMoney(order.breakdown.vatMinor, currency),
                  ink: ink,
                  muted: muted,
                ),
                pw.Container(
                  color: brand,
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Total',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        formatMoney(order.breakdown.totalMinor, currency),
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                if (order.depositMinor > 0) ...[
                  _sumRow(
                    'Deposit',
                    formatMoney(order.depositMinor, currency),
                    ink: ink,
                    muted: muted,
                  ),
                  if (order.depositAt.isNotEmpty)
                    _sumRow(
                      'Deposit date',
                      formatIsoDate(order.depositAt),
                      ink: ink,
                      muted: muted,
                    ),
                  _sumRow(
                    order.status == OrderStatus.paid ? 'Balance' : 'Still to pay',
                    formatMoney(
                      order.breakdown.totalMinor - order.depositMinor,
                      currency,
                    ),
                    ink: ink,
                    muted: muted,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (prints.length == 1) ...[
          pw.SizedBox(height: 10),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              '${formatMoney(prints.single.breakdown.perUnitMinor, currency)} per unit, incl. VAT',
              style: quiet,
            ),
          ),
        ],
        if (valid.isNotEmpty) ...[
          pw.SizedBox(height: 18),
          pw.Text('This quote is valid until $valid.', style: quiet),
        ],
      ],
    ),
  );
  return doc.save();
}

List<String> _filledLines(Iterable<String> parts) {
  return [
    for (final part in parts)
      if (part.trim().isNotEmpty) part.trim(),
  ];
}

String _vatLabel(List<QuoteLine> prints) {
  if (prints.isEmpty) {
    return 'VAT';
  }
  final rate = prints.first.vatBasisPoints;
  if (prints.every((line) => line.vatBasisPoints == rate)) {
    return 'VAT ${formatPercent(rate)}';
  }
  return 'VAT';
}

int _unitNet(QuoteLine line) {
  final quantity = line.quantity <= 0 ? 1 : line.quantity;
  return (line.breakdown.netMinor / quantity).round();
}

String _lineDetail(QuoteLine line) {
  final seen = <String>{};
  final parts = <String>[];
  void add(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || !seen.add(trimmed.toLowerCase())) {
      return;
    }
    parts.add(trimmed);
  }

  add(line.sourceProfileTitle);
  for (final filament in line.filaments) {
    add(filament.material);
  }
  return parts.join(' · ');
}

pw.Widget _sumRow(
  String label,
  String value, {
  required PdfColor ink,
  required PdfColor muted,
}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: pw.TextStyle(fontSize: 10, color: muted)),
        pw.Text(value, style: pw.TextStyle(fontSize: 10, color: ink)),
      ],
    ),
  );
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
    } on Object catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not share the quote. $error')),
        );
      }
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
