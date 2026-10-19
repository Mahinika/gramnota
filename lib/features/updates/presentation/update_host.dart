import 'dart:async';

import 'package:flutter/material.dart';

import 'update_launcher.dart';

/// Asks about a newer build once the navigator exists, at most once a day.
class UpdateHost extends StatefulWidget {
  const UpdateHost({
    required this.navigatorKey,
    required this.child,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  @override
  State<UpdateHost> createState() => _UpdateHostState();
}

class _UpdateHostState extends State<UpdateHost> {
  var _attempts = 0;
  var _started = false;

  @override
  void initState() {
    super.initState();
    _schedule();
  }

  void _schedule() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _started) {
        return;
      }
      final navigatorContext = widget.navigatorKey.currentContext;
      if (navigatorContext == null || !navigatorContext.mounted) {
        if (_attempts++ < 8) {
          _schedule();
        }
        return;
      }
      _started = true;
      unawaited(promptForUpdate(navigatorContext, manual: false));
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
