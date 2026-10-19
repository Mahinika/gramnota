import 'package:gramnota/l10n/l10n.dart';

import '../domain/sign_in_failed.dart';

export '../domain/sign_in_failed.dart';

/// Web and other builds never open the desktop browser flow.
Future<DesktopGoogleCredential> requestDesktopGoogleCredential({
  required String apiKey,
  required String authDomain,
  required String projectId,
  required String appId,
  String? storageBucket,
  Future<bool> Function(Uri url)? openBrowser,
  Duration timeout = const Duration(minutes: 5),
  AppLocalizations? l10n,
}) async {
  throw SignInFailed((l10n ?? activeGramnotaL10n).authGooglePlatforms);
}
