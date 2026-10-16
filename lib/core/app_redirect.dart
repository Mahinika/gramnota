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
  const leave = {'/workshop-setup', '/starting', '/sign-in', '/setup'};
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
}) {
  if (!firebaseConfigured) {
    return location == '/setup' ? null : '/setup';
  }
  if (authLoading) {
    return location == '/starting' ? null : '/starting';
  }
  if (!signedIn) {
    return location == '/sign-in' ? null : '/sign-in';
  }
  return workshopRedirect(
    location: location,
    setupCompleted: setupCompleted,
    finishedLocally: finishedLocally,
  );
}
