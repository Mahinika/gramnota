import '../features/settings/domain/workshop_settings.dart';
import 'app_language_controller.dart';
import 'app_theme_controller.dart';
import 'user_store.dart';

/// Pushes the workshop document's language and appearance into the local
/// controllers. A missing document is skipped so the first-run choice stays
/// until setup saves one. An older snapshot does not undo a newer local save.
void applyRemoteWorkshopLocale({
  required UserStore store,
  required WorkshopSettings settings,
  required AppLanguageController language,
  required AppThemeController theme,
}) {
  if (!store.settingsDocumentExists) {
    return;
  }
  language.applyRemote(
    settings.languageCode,
    updatedAt: settings.languageUpdatedAt,
  );
  theme.applyRemote(settings.themeMode, updatedAt: settings.themeUpdatedAt);
}
