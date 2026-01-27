import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BorderSide? side;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.side,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: side ?? BorderSide(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(10), // Matching --radius
      ),
      color: color ?? Theme.of(context).cardTheme.color,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(24.0),
        child: child,
      ),
    );
  }
}