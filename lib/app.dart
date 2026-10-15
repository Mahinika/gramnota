import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers.dart';
import 'core/theme.dart';
import 'router.dart';

class GramnotaApp extends ConsumerWidget {
  const GramnotaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(sharedLinkBootstrapProvider);
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Gramnota',
      theme: buildGramnotaTheme(),
      routerConfig: router,
    );
  }
}
