import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/features/sharing/domain/inbox_item.dart';

void main() {
  test('directory entry stores uid and display name only', () {
    final data = directoryEntryData(
      uid: 'alice',
      displayName: '  Alice  ',
    );

    expect(data, {'uid': 'alice', 'displayName': 'Alice'});
    expect(data.containsKey('email'), isFalse);
  });

  test('directory display name is capped at the rules limit', () {
    final data = directoryEntryData(
      uid: 'alice',
      displayName: 'A' * (directoryDisplayNameMax + 25),
    );

    expect(data['displayName']!.length, directoryDisplayNameMax);
  });

  test('ensureDirectory writes the lookup fields and no email', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'alice');

    await store.ensureDirectory(
      email: ' Alice@Example.com ',
      displayName: 'Alice',
    );

    final saved = await firestore
        .collection('userDirectory')
        .doc('alice@example.com')
        .get();
    expect(saved.data(), {'uid': 'alice', 'displayName': 'Alice'});
  });

  test('sendToUser writes a server timestamp and the inbox whitelist', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'alice');

    await store.sendToUser(
      recipientUid: 'bob',
      type: SharedItemType.printer,
      payload: {'name': 'Prusa'},
      senderName: ' Alice ',
      senderEmail: 'Alice@Example.com',
    );

    final saved = await firestore
        .collection('users')
        .doc('bob')
        .collection('inbox')
        .get();
    expect(saved.docs, hasLength(1));
    final data = saved.docs.single.data();
    expect(data.keys, {
      'type',
      'payloadJson',
      'senderUid',
      'senderName',
      'senderEmail',
      'createdAt',
    });
    expect(data['type'], 'printer');
    expect(data['payloadJson'], '{"name":"Prusa"}');
    expect(data['senderUid'], 'alice');
    expect(data['senderName'], 'Alice');
    expect(data['senderEmail'], 'Alice@Example.com');
    expect(data['createdAt'], isA<Timestamp>());
    expect(data.containsKey('id'), isFalse);
  });

  test('sendToUser rejects an oversized payload before writing', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'alice');

    await expectLater(
      store.sendToUser(
        recipientUid: 'bob',
        type: SharedItemType.order,
        payload: {'note': 'x' * inboxPayloadMaxChars},
        senderName: 'Alice',
        senderEmail: 'alice@example.com',
      ),
      throwsA(isA<InboxPayloadTooLarge>()),
    );
    expect(
      (await firestore
              .collection('users')
              .doc('bob')
              .collection('inbox')
              .get())
          .docs,
      isEmpty,
    );
  });

  test('inbox timestamps from the server and from older items both decode', () async {
    final firestore = FakeFirebaseFirestore();
    final stamp = Timestamp.fromDate(DateTime.utc(2026, 1, 2, 3, 4, 5));
    await firestore
        .collection('users')
        .doc('bob')
        .collection('inbox')
        .doc('new-item')
        .set({
          'type': 'filament',
          'payloadJson': '{"brand":"Prusa"}',
          'senderUid': 'alice',
          'senderName': 'Alice',
          'senderEmail': 'alice@example.com',
          'createdAt': stamp,
        });
    await firestore
        .collection('users')
        .doc('bob')
        .collection('inbox')
        .doc('old-item')
        .set({
          'type': 'customer',
          'payloadJson': '{"name":"Ada"}',
          'senderUid': 'alice',
          'senderName': 'Alice',
          'senderEmail': 'alice@example.com',
          'createdAt': '2024-05-01T00:00:00.000Z',
        });

    final items = await UserStore(firestore, 'bob').watchInbox().first;

    expect(inboxCreatedAtText(stamp), '2026-01-02T03:04:05.000Z');
    expect(inboxCreatedAtText('2024-05-01T00:00:00.000Z'), '2024-05-01T00:00:00.000Z');
    expect(inboxCreatedAtText(null), isEmpty);
    expect(items, hasLength(2));
    expect(
      items.map((item) => item.createdAt),
      containsAll([
        '2026-01-02T03:04:05.000Z',
        '2024-05-01T00:00:00.000Z',
      ]),
    );
  });
}
