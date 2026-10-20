/// Where a signed-in user should go while setup is unknown, unfinished, or done.
String? workshopRedirect({
  required String location,
  required bool? setupCompleted,
  required bool finishedLocally,
}) {
  final done = finishedLocally || setupCompleted == true;
  if (setupCompleted == null && !finishedLocally) {
    return location == '/starting' ? null : '/starting';
  }
  if (!done) {
    return location == '/workshop-setup' ? null : '/workshop-setup';
  }
  const leave = {
    '/workshop-setup',
    '/starting',
    '/sign-in',
    '/setup',
    '/choose-language',
  };
  if (leave.contains(location)) {
    return '/calculator';
  }
  return null;
}

String? resolveRedirect({
  required String location,
  required bool firebaseConfigured,
  required bool authLoading,
  required bool signedIn,
  required bool? setupCompleted,
  required bool finishedLocally,
  bool showLanguageOnboarding = false,
}) {
  if (!firebaseConfigured) {
    return location == '/setup' ? null : '/setup';
  }
  if (authLoading) {
    return location == '/starting' ? null : '/starting';
  }
  if (!signedIn) {
    if (showLanguageOnboarding) {
      return location == '/choose-language' ? null : '/choose-language';
    }
    return location == '/sign-in' ? null : '/sign-in';
  }
  return workshopRedirect(
    location: location,
    setupCompleted: setupCompleted,
    finishedLocally: finishedLocally,
  );
}
