import 'package:flutter/material.dart';
import 'package:genis_website/src/theme/app_theme.dart';

enum AppBadgeVariant {
  defaultVariant,
  secondary,
  destructive,
  outline,
  success,
  warning,
  info,
}

class AppBadge extends StatelessWidget {
  final String label;
  final AppBadgeVariant variant;
  
  // Backwards compatibility for one-off colors if needed, but prefer variants
  final Color? backgroundColor;
  final Color? foregroundColor;

  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.defaultVariant,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    BorderSide border = BorderSide.none;

    if (backgroundColor != null && foregroundColor != null) {
      bg = backgroundColor!;
      fg = foregroundColor!;
    } else {
      switch (variant) {
        case AppBadgeVariant.defaultVariant:
          bg = AppTheme.slate900;
          fg = AppTheme.slate50;
          break;
        case AppBadgeVariant.secondary:
          bg = AppTheme.slate100;
          fg = AppTheme.slate900;
          break;
        case AppBadgeVariant.destructive:
          bg = Colors.red; // red-500
          fg = AppTheme.slate50;
          break;
        case AppBadgeVariant.outline:
          bg = Colors.transparent;
          fg = AppTheme.slate950;
          border = const BorderSide(color: AppTheme.slate200);
          break;
        case AppBadgeVariant.success:
          bg = const Color(0xFFDCFCE7); // green-100
          fg = const Color(0xFF14532D); // green-900
          break;
        case AppBadgeVariant.warning:
          bg = const Color(0xFFFEF9C3); // yellow-100
          fg = const Color(0xFF713F12); // yellow-900
          break;
        case AppBadgeVariant.info:
          bg = const Color(0xFFDBEAFE); // blue-100
          fg = const Color(0xFF1E3A8A); // blue-900
          break;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2), // px-2.5 py-0.5
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999), // rounded-full
        border: border != BorderSide.none ? Border.fromBorderSide(border) : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 12, // text-xs
          fontWeight: FontWeight.w600, // font-semibold
        ),
      ),
    );
  }
}