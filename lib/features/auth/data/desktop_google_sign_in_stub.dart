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
}) async {
  throw const SignInFailed(
    'Google sign-in is available in the Android and Windows apps.',
  );
}
