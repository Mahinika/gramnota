import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/auth/domain/account_deletion.dart';

void main() {
  test('a failed reauthentication leaves workshop data and the user', () async {
    final steps = <String>[];
    final deletion = AccountDeletion(
      reauthenticate: () async {
        steps.add('reauth');
        throw StateError('requires-recent-login');
      },
      deleteOwnedData: () async => steps.add('data'),
      deleteUser: () async => steps.add('user'),
    );

    await expectLater(deletion.run(), throwsStateError);
    expect(steps, ['reauth']);
  });

  test('workshop data is deleted before the auth user', () async {
    final steps = <String>[];
    final deletion = AccountDeletion(
      reauthenticate: () async => steps.add('reauth'),
      deleteOwnedData: () async => steps.add('data'),
      deleteUser: () async => steps.add('user'),
    );

    await deletion.run();
    expect(steps, ['reauth', 'data', 'user']);
  });

  test('a data failure does not delete the auth user', () async {
    final steps = <String>[];
    final deletion = AccountDeletion(
      reauthenticate: () async => steps.add('reauth'),
      deleteOwnedData: () async {
        steps.add('data');
        throw StateError('firestore');
      },
      deleteUser: () async => steps.add('user'),
    );

    await expectLater(deletion.run(), throwsStateError);
    expect(steps, ['reauth', 'data']);
  });
}
