import 'package:flutter/material.dart';
import 'package:genis_website/src/theme/app_theme.dart';

enum AppButtonVariant {
  defaultVariant,
  destructive,
  outline,
  secondary,
  ghost,
  link,
}

enum AppButtonSize {
  defaultSize,
  sm,
  lg,
  icon,
}

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child; // Usually Text
  final String? label; // Shortcut for Text
  final IconData? icon; // Optional icon
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;

  const AppButton({
    super.key,
    this.onPressed,
    this.child,
    this.label,
    this.icon,
    this.variant = AppButtonVariant.defaultVariant,
    this.size = AppButtonSize.defaultSize,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine Colors & Style
    Color? bgColor;
    Color? fgColor;
    Color? borderColor;
    Color? hoverBgColor;
    
    // Base styles
    switch (variant) {
      case AppButtonVariant.defaultVariant:
        bgColor = AppTheme.slate900;
        fgColor = Colors.white; // slate-50
        hoverBgColor = AppTheme.slate900.withValues(alpha: 0.9);
        break;
      case AppButtonVariant.destructive:
        bgColor = Colors.red; // red-500
        fgColor = Colors.white;
        hoverBgColor = Colors.red.withValues(alpha: 0.9);
        break;
      case AppButtonVariant.outline:
        bgColor = Colors.white;
        fgColor = AppTheme.slate900;
        borderColor = AppTheme.slate200;
        hoverBgColor = AppTheme.slate100;
        break;
      case AppButtonVariant.secondary:
        bgColor = AppTheme.slate100;
        fgColor = AppTheme.slate900;
        hoverBgColor = AppTheme.slate100.withValues(alpha: 0.8);
        break;
      case AppButtonVariant.ghost:
        bgColor = Colors.transparent;
        fgColor = AppTheme.slate900;
        hoverBgColor = AppTheme.slate100;
        break;
      case AppButtonVariant.link:
        bgColor = Colors.transparent;
        fgColor = AppTheme.slate900;
        break;
    }

    // Determine Size
    EdgeInsetsGeometry padding;
    double height;
    double? width;
    
    switch (size) {
      case AppButtonSize.defaultSize:
        height = 40;
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        break;
      case AppButtonSize.sm:
        height = 36;
        padding = const EdgeInsets.symmetric(horizontal: 12);
        break;
      case AppButtonSize.lg:
        height = 44;
        padding = const EdgeInsets.symmetric(horizontal: 32);
        break;
      case AppButtonSize.icon:
        height = 40;
        width = 40;
        padding = EdgeInsets.zero;
        break;
    }

    // Build the button
    final style = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered) && hoverBgColor != null) {
          return hoverBgColor;
        }
        return bgColor;
      }),
      foregroundColor: WidgetStatePropertyAll(fgColor),
      side: borderColor != null ? WidgetStatePropertyAll(BorderSide(color: borderColor)) : null,
      padding: WidgetStatePropertyAll(padding),
      minimumSize: WidgetStatePropertyAll(Size(width ?? 0, height)),
      fixedSize: width != null ? WidgetStatePropertyAll(Size(width, height)) : null,
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), // rounded-md ~= 6
      elevation: const WidgetStatePropertyAll(0),
      textStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      overlayColor: WidgetStatePropertyAll(fgColor.withValues(alpha: 0.1)),
    );

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2)),
          if (label != null || child != null) const SizedBox(width: 8),
        ] else if (icon != null) ...[
          Icon(icon, size: 16),
          if (label != null || child != null) const SizedBox(width: 8),
        ],
        if (label != null) Text(label!) else if (child != null) child!,
      ],
    );

    if (variant == AppButtonVariant.link) {
      return TextButton(
        onPressed: onPressed,
        style: style.copyWith(
          overlayColor: WidgetStatePropertyAll(AppTheme.slate900.withValues(alpha: 0.05)),
          backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        ),
        child: content,
      );
    }

    if (variant == AppButtonVariant.outline) {
      return OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: content,
      );
    }

    // Default, Destructive, Secondary, Ghost (using TextButton for ghost effectively, but FilledButton logic works if bg is transparent)
    return FilledButton(
      onPressed: onPressed,
      style: style,
      child: content,
    );
  }
}
