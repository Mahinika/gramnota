import 'package:flutter/material.dart';

const _brandGreen = Color(0xFF0F6E56);

class GramnotaBrandMark extends StatelessWidget {
  const GramnotaBrandMark({this.size = 96, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final padding = size * 0.125;
    final imageSize = size - padding * 2;
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: _brandGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        'assets/brand/gramnota_mark.png',
        width: imageSize,
        height: imageSize,
        fit: BoxFit.contain,
      ),
    );
  }
}

class GateScaffold extends StatelessWidget {
  const GateScaffold({
    required this.title,
    required this.child,
    this.subtitle,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const GramnotaBrandMark(),
                const SizedBox(height: 20),
                Text(title, style: theme.textTheme.headlineMedium),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(subtitle!, textAlign: TextAlign.center),
                ],
                const SizedBox(height: 24),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
