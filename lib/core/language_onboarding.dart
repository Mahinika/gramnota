import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_language_controller.dart';

const languageOnboardingSeenKey = 'gramnota_language_onboarding_seen';

/// A non-empty cached language means this device already chose one.
bool hasCachedLanguagePreference(String? stored) {
  return stored != null && stored.trim().isNotEmpty;
}

/// The first-run language screen is once per device.
/// A cache from an earlier install skips it, and so does the seen flag.
bool shouldShowLanguageOnboarding({
  required bool seen,
  required bool hasCachedLanguage,
}) {
  if (seen || hasCachedLanguage) {
    return false;
  }
  return true;
}

/// True while the choose-language screen should be the signed-out gate.
class LanguageOnboardingController extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return shouldShowLanguageOnboarding(
      seen: prefs.getBool(languageOnboardingSeenKey) ?? false,
      hasCachedLanguage: hasCachedLanguagePreference(
        prefs.getString(languagePreferenceKey),
      ),
    );
  }

  /// Stores the choice and hides the screen on later launches.
  Future<void> confirm(String languageCode) async {
    await ref.read(appLanguageProvider.notifier).setLanguage(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(languageOnboardingSeenKey, true);
    state = const AsyncData(false);
  }
}

final showLanguageOnboardingProvider =
    AsyncNotifierProvider<LanguageOnboardingController, bool>(
      LanguageOnboardingController.new,
    );
