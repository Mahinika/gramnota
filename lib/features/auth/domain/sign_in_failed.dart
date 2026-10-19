/// A sign-in failure with a message the sign-in screen can show as-is.
class SignInFailed implements Exception {
  const SignInFailed(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Google tokens from the desktop browser flow.
class DesktopGoogleCredential {
  const DesktopGoogleCredential({this.idToken, this.accessToken});

  final String? idToken;
  final String? accessToken;

  bool get hasToken => idToken != null || accessToken != null;
}
