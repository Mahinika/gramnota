import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/app_languages.dart';
import '../../../core/format.dart';
import '../../../l10n/l10n.dart';
import '../../customers/domain/customer.dart';
import '../../settings/domain/workshop_settings.dart';
import '../domain/print_order.dart';

/// Customer PDF language. A stored quote language wins. Otherwise the app
/// locale passed by the preview, then the active workshop language.
AppLocalizations quoteDocumentL10n(PrintOrder order, String? quoteLocale) {
  final stored = order.quoteLanguage.trim();
  if (stored.isNotEmpty) {
    final code = normalizeLanguageCode(stored);
    if (code != systemLanguageCode) {
      return lookupAppLocalizations(Locale(code));
    }
  }
  final passed = (quoteLocale ?? '').trim();
  if (passed.isNotEmpty) {
    final code = normalizeLanguageCode(passed);
    if (code != systemLanguageCode) {
      return lookupAppLocalizations(Locale(code));
    }
  }
  return activeGramnotaL10n;
}

Future<Uint8List> buildQuotePdf({
  required PrintOrder order,
  required WorkshopSettings settings,
  required Customer? customer,
  String? quoteLocale,
}) async {
  final l10n = quoteDocumentL10n(order, quoteLocale);
  final locale = l10n.localeName;
  final currency = order.currencyCode;
  String money(int minor) => formatMoney(minor, currency, locale: locale);
  String dateText(String iso) => formatIsoDate(iso, locale: locale);
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
      l10n.pdfOrgNo(settings.orgNumber.trim()),
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
  final issued = dateText(order.createdAt);
  final valid = dateText(order.validUntil);
  final vatLabel = _vatLabel(prints, l10n);

  pw.Widget party(String title, List<String> lines) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: label),
        pw.SizedBox(height: 6),
        pw.Text(
          lines.isEmpty ? l10n.pdfNotSpecified : lines.join('\n'),
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
                l10n.pdfPageOf(context.pageNumber, context.pagesCount),
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
                    ? l10n.pdfQuote
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
                pw.Text(l10n.pdfQuoteHeading, style: label),
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
              meta(l10n.pdfQuoteNo, '${order.quoteNumber}'),
              meta(l10n.pdfIssued, issued),
              meta(l10n.pdfValidUntil, valid),
            ],
          ),
        ),
        pw.SizedBox(height: 18),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(child: party(l10n.pdfFrom, seller)),
            pw.SizedBox(width: 28),
            pw.Expanded(child: party(l10n.pdfBillTo, buyer)),
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
                cell(l10n.pdfDescription, header: true),
                cell(l10n.pdfQty, header: true, align: pw.Alignment.center),
                cell(
                  l10n.pdfUnitPrice,
                  header: true,
                  align: pw.Alignment.centerRight,
                ),
                cell(
                  l10n.pdfAmount,
                  header: true,
                  align: pw.Alignment.centerRight,
                ),
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
                    _unitPriceText(prints[index], money),
                    align: pw.Alignment.centerRight,
                  ),
                  cell(
                    money(prints[index].breakdown.netMinor),
                    align: pw.Alignment.centerRight,
                    strong: true,
                  ),
                ],
              ),
          ],
        ),
        pw.SizedBox(height: 6),
        pw.Text(l10n.pdfLineAmountsNote, style: quiet),
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
                  l10n.pdfSubtotal,
                  money(order.breakdown.netMinor),
                  ink: ink,
                  muted: muted,
                ),
                _sumRow(
                  vatLabel,
                  money(order.breakdown.vatMinor),
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
                        l10n.pdfTotal,
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        money(order.breakdown.totalMinor),
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
                    l10n.pdfDeposit,
                    money(order.depositMinor),
                    ink: ink,
                    muted: muted,
                  ),
                  if (order.depositAt.isNotEmpty)
                    _sumRow(
                      l10n.pdfDepositDate,
                      dateText(order.depositAt),
                      ink: ink,
                      muted: muted,
                    ),
                  _sumRow(
                    order.status == OrderStatus.paid
                        ? l10n.pdfBalance
                        : l10n.pdfStillToPay,
                    money(order.breakdown.totalMinor - order.depositMinor),
                    ink: ink,
                    muted: muted,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (prints.length == 1 &&
            exactUnitMinor(
                  prints.single.breakdown.totalMinor,
                  prints.single.quantity,
                ) !=
                null) ...[
          pw.SizedBox(height: 10),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              l10n.pdfPerUnit(
                money(
                  exactUnitMinor(
                    prints.single.breakdown.totalMinor,
                    prints.single.quantity,
                  )!,
                ),
              ),
              style: quiet,
            ),
          ),
        ],
        if (valid.isNotEmpty) ...[
          pw.SizedBox(height: 18),
          pw.Text(l10n.pdfValidUntilSentence(valid), style: quiet),
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

String _vatLabel(List<QuoteLine> prints, AppLocalizations l10n) {
  if (prints.isEmpty) {
    return l10n.pdfVat;
  }
  final rate = prints.first.vatBasisPoints;
  if (prints.every((line) => line.vatBasisPoints == rate)) {
    return l10n.pdfVatRate(formatPercent(rate, locale: l10n.localeName));
  }
  return l10n.pdfVat;
}

/// Unit amount that multiplies back to [amountMinor].
///
/// Null when the division is not exact, so a customer document never shows
/// a unit price whose product disagrees with the line or the total.
int? exactUnitMinor(int amountMinor, int quantity) {
  if (quantity <= 0) {
    return null;
  }
  if (amountMinor % quantity != 0) {
    return null;
  }
  return amountMinor ~/ quantity;
}

String _unitPriceText(QuoteLine line, String Function(int minor) money) {
  final unit = exactUnitMinor(line.breakdown.netMinor, line.quantity);
  if (unit == null) {
    return '—';
  }
  return money(unit);
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
  String? quoteLocale,
}) async {
  final l10n = quoteDocumentL10n(order, quoteLocale);
  final bytes = await buildQuotePdf(
    order: order,
    settings: settings,
    customer: customer,
    quoteLocale: quoteLocale,
  );
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/quote-${order.quoteNumber}.pdf');
  await file.writeAsBytes(bytes, flush: true);
  await SharePlus.instance.share(
    ShareParams(
      files: [XFile(file.path)],
      subject: l10n.orderQuoteNumber(order.quoteNumber),
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
        quoteLocale: Localizations.localeOf(context).toString(),
      );
    } on Object catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.orderShareFailed('$error'))),
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
    final l10n = context.l10n;
    final quoteLocale = Localizations.localeOf(context).toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.orderQuoteNumber(widget.order.quoteNumber)),
        actions: [
          IconButton(
            tooltip: l10n.orderShareQuote,
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
          quoteLocale: quoteLocale,
        ),
      ),
    );
  }
}
