import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Monochrome Gramnota icon. The asset is black; [color] tints it.
class GramnotaSvgIcon extends StatelessWidget {
  const GramnotaSvgIcon(this.name, {this.size = 24, this.color, super.key});

  final String name;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? IconTheme.of(context).color;
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      width: size,
      height: size,
      colorFilter: tint == null
          ? null
          : ColorFilter.mode(tint, BlendMode.srcIn),
    );
  }
}

class BrandIconWell extends StatelessWidget {
  const BrandIconWell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: IconTheme(
        data: IconThemeData(color: scheme.onPrimaryContainer, size: 22),
        child: child,
      ),
    );
  }
}
