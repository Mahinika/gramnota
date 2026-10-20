import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_language_controller.dart';
import '../../../core/app_languages.dart';
import '../../../core/gate_scaffold.dart';
import '../../../core/language_onboarding.dart';
import '../../../core/menu_card.dart';
import '../../../l10n/l10n.dart';

/// First screen on a new device, before Google sign-in.
/// Tapping a language switches the whole app immediately.
class ChooseLanguageScreen extends ConsumerStatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  ConsumerState<ChooseLanguageScreen> createState() =>
      _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends ConsumerState<ChooseLanguageScreen> {
  var _saving = false;

  String _selected(String? current) {
    if (current == null || current == systemLanguageCode) {
      return languageForDeviceLocale(
        WidgetsBinding.instance.platformDispatcher.locale,
      );
    }
    final normalized = normalizeLanguageCode(current);
    if (onboardingLanguageCodes.contains(normalized)) {
      return normalized;
    }
    return firstRunFallbackLanguageCode;
  }

  Future<void> _continue(String languageCode) async {
    if (_saving) {
      return;
    }
    setState(() => _saving = true);
    await ref.read(showLanguageOnboardingProvider.notifier).confirm(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final selected = _selected(ref.watch(appLanguageProvider).asData?.value);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                children: [
                  const GramnotaBrandMark(size: 72),
                  const SizedBox(height: 16),
                  Text(
                    l10n.chooseLanguageTitle,
                    style: theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.chooseLanguageBody, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: onboardingLanguageCodes.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final code = onboardingLanguageCodes[index];
                        final isSelected = code == selected;
                        return TappableListCard(
                          onTap: _saving
                              ? null
                              : () => ref
                                    .read(appLanguageProvider.notifier)
                                    .previewLanguage(code),
                          child: Row(
                            children: [
                              Text(
                                languageFlag(code),
                                style: const TextStyle(fontSize: 28),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  languageEndonyms[code] ?? code,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: theme.colorScheme.primary,
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _saving ? null : () => _continue(selected),
                      child: Text(
                        _saving ? l10n.saving : l10n.actionContinue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
