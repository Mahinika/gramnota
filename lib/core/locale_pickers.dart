import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import 'app_languages.dart';
import 'currencies.dart';
import 'theme_mode.dart';

/// Workshop language: system default, then each shipped language in its own name.
class LanguageMenu extends StatelessWidget {
  const LanguageMenu({
    required this.languageCode,
    required this.onChanged,
    super.key,
  });

  final String languageCode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final value = languageCode == systemLanguageCode
        ? systemLanguageCode
        : normalizeLanguageCode(languageCode);
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: l10n.languageLabel),
      items: [
        DropdownMenuItem(
          value: systemLanguageCode,
          child: Text(l10n.languageSystem, overflow: TextOverflow.ellipsis),
        ),
        for (final code in supportedLanguageCodes)
          DropdownMenuItem(
            value: code,
            child: Text(
              languageEndonyms[code] ?? code,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: (next) {
        if (next != null) {
          onChanged(next);
        }
      },
    );
  }
}

/// Workshop appearance: system, light, or dark.
class ThemeMenu extends StatelessWidget {
  const ThemeMenu({
    required this.themeMode,
    required this.onChanged,
    super.key,
  });

  final String themeMode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final value = normalizeThemeMode(themeMode);
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: l10n.themeLabel),
      items: [
        DropdownMenuItem(
          value: systemThemeCode,
          child: Text(l10n.themeSystem, overflow: TextOverflow.ellipsis),
        ),
        DropdownMenuItem(
          value: lightThemeCode,
          child: Text(l10n.themeLight, overflow: TextOverflow.ellipsis),
        ),
        DropdownMenuItem(
          value: darkThemeCode,
          child: Text(l10n.themeDark, overflow: TextOverflow.ellipsis),
        ),
      ],
      onChanged: (next) {
        if (next != null) {
          onChanged(next);
        }
      },
    );
  }
}

/// ISO 4217 currency. Featured codes are listed first. Search covers code and name.
Future<String?> pickCurrency(
  BuildContext context, {
  required String selected,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => _CurrencySheet(selected: normalizeCurrencyCode(selected)),
  );
}

class CurrencyField extends StatelessWidget {
  const CurrencyField({
    required this.currencyCode,
    required this.onChanged,
    super.key,
  });

  final String currencyCode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final code = normalizeCurrencyCode(currencyCode);
    final locale = context.formattingLocale;
    final symbol = currencySymbol(code, locale: locale);
    final name = iso4217Currencies[code] ?? code;
    return InkWell(
      onTap: () async {
        final next = await pickCurrency(context, selected: code);
        if (next != null && next != code) {
          onChanged(next);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(labelText: context.l10n.currencyLabel),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '$code · $symbol · $name',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

class _CurrencySheet extends StatefulWidget {
  const _CurrencySheet({required this.selected});

  final String selected;

  @override
  State<_CurrencySheet> createState() => _CurrencySheetState();
}

class _CurrencySheetState extends State<_CurrencySheet> {
  final _query = TextEditingController();
  String _filter = '';

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = context.formattingLocale;
    final needle = _filter.trim().toLowerCase();
    final codes = [
      for (final code in currencyCodesInPickerOrder())
        if (needle.isEmpty || currencySearchText(code).contains(needle)) code,
    ];
    final height = MediaQuery.sizeOf(context).height * 0.75;
    return SafeArea(
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                controller: _query,
                decoration: InputDecoration(
                  labelText: l10n.currencySearch,
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) => setState(() => _filter = value),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: codes.length,
                itemBuilder: (context, index) {
                  final code = codes[index];
                  final symbol = currencySymbol(code, locale: locale);
                  final name = iso4217Currencies[code] ?? code;
                  return ListTile(
                    selected: code == widget.selected,
                    title: Text(
                      '$code · $symbol',
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(name, overflow: TextOverflow.ellipsis),
                    onTap: () => Navigator.pop(context, code),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Customer PDF language. Empty [quoteLanguage] means the app language.
class QuoteLanguageMenu extends StatelessWidget {
  const QuoteLanguageMenu({
    required this.quoteLanguage,
    required this.onChanged,
    super.key,
  });

  final String quoteLanguage;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final stored = quoteLanguage.trim().toLowerCase();
    final value = stored.isEmpty ? '' : normalizeLanguageCode(stored);
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: l10n.quoteLanguageLabel),
      items: [
        DropdownMenuItem(
          value: '',
          child: Text(l10n.quoteLanguageApp, overflow: TextOverflow.ellipsis),
        ),
        for (final code in supportedLanguageCodes)
          DropdownMenuItem(
            value: code,
            child: Text(
              languageEndonyms[code] ?? code,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: (next) {
        if (next != null) {
          onChanged(next);
        }
      },
    );
  }
}
