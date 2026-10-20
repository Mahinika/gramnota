/// Deletes a Gramnota account without emptying the workshop first.
///
/// Firebase Auth refuses `User.delete` until the sign-in is recent. Doing
/// that check first means a `requires-recent-login` failure leaves Firestore
/// untouched. Workshop data is removed only after reauthentication, while the
/// user is still signed in, because security rules reject writes once the
/// Auth user is gone. The Auth user is deleted last.
class AccountDeletion {
  const AccountDeletion({
    required this.reauthenticate,
    required this.deleteOwnedData,
    required this.deleteUser,
  });

  final Future<void> Function() reauthenticate;
  final Future<void> Function() deleteOwnedData;
  final Future<void> Function() deleteUser;

  Future<void> run() async {
    await reauthenticate();
    await deleteOwnedData();
    await deleteUser();
  }
}
