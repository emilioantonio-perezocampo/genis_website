import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const AppBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(999), // Rounded full
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: foregroundColor ?? theme.colorScheme.onSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
