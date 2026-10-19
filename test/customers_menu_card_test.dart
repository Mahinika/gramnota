import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/menu_card.dart';
import 'package:gramnota/l10n/l10n.dart';

void main() {
  testWidgets('menu card with icon buttons builds', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: TappableListCard(
            onTap: () {},
            child: Row(
              children: [
                const CircleAvatar(child: Text('AB')),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    expect(find.byType(TappableListCard), findsOneWidget);
  });
}
