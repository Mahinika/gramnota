import 'package:flutter/material.dart';

/// Tappable list row with the same card chrome as the order list.
class TappableListCard extends StatelessWidget {
  const TappableListCard({
    required this.child,
    this.onTap,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;

  static const listPadding = EdgeInsets.fromLTRB(16, 4, 16, 16);
  static const listSeparator = SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
