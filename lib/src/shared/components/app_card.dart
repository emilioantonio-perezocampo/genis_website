import 'package:flutter/material.dart';
import 'package:genis_website/src/theme/app_theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BorderSide? side;
  final bool shadow;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.side,
    this.shadow = true, // Default to shadow-sm
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10), // --radius
        border: Border.fromBorderSide(side ?? BorderSide(color: Theme.of(context).colorScheme.outline)),
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(24.0),
        child: child,
      ),
    );
  }
}
