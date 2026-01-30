// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.chart1,
    required this.chart2,
    required this.chart3,
    required this.chart4,
    required this.chart5,
    required this.sidebarBackground,
    required this.sidebarForeground,
    required this.sidebarPrimary,
    required this.sidebarPrimaryForeground,
    required this.sidebarAccent,
    required this.sidebarAccentForeground,
    required this.sidebarBorder,
    required this.sidebarRing,
  });

  final Color chart1;
  final Color chart2;
  final Color chart3;
  final Color chart4;
  final Color chart5;
  
  final Color sidebarBackground;
  final Color sidebarForeground;
  final Color sidebarPrimary;
  final Color sidebarPrimaryForeground;
  final Color sidebarAccent;
  final Color sidebarAccentForeground;
  final Color sidebarBorder;
  final Color sidebarRing;

  @override
  AppColors copyWith({
    Color? chart1,
    Color? chart2,
    Color? chart3,
    Color? chart4,
    Color? chart5,
    Color? sidebarBackground,
    Color? sidebarForeground,
    Color? sidebarPrimary,
    Color? sidebarPrimaryForeground,
    Color? sidebarAccent,
    Color? sidebarAccentForeground,
    Color? sidebarBorder,
    Color? sidebarRing,
  }) {
    return AppColors(
      chart1: chart1 ?? this.chart1,
      chart2: chart2 ?? this.chart2,
      chart3: chart3 ?? this.chart3,
      chart4: chart4 ?? this.chart4,
      chart5: chart5 ?? this.chart5,
      sidebarBackground: sidebarBackground ?? this.sidebarBackground,
      sidebarForeground: sidebarForeground ?? this.sidebarForeground,
      sidebarPrimary: sidebarPrimary ?? this.sidebarPrimary,
      sidebarPrimaryForeground: sidebarPrimaryForeground ?? this.sidebarPrimaryForeground,
      sidebarAccent: sidebarAccent ?? this.sidebarAccent,
      sidebarAccentForeground: sidebarAccentForeground ?? this.sidebarAccentForeground,
      sidebarBorder: sidebarBorder ?? this.sidebarBorder,
      sidebarRing: sidebarRing ?? this.sidebarRing,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      chart1: Color.lerp(chart1, other.chart1, t)!,
      chart2: Color.lerp(chart2, other.chart2, t)!,
      chart3: Color.lerp(chart3, other.chart3, t)!,
      chart4: Color.lerp(chart4, other.chart4, t)!,
      chart5: Color.lerp(chart5, other.chart5, t)!,
      sidebarBackground: Color.lerp(sidebarBackground, other.sidebarBackground, t)!,
      sidebarForeground: Color.lerp(sidebarForeground, other.sidebarForeground, t)!,
      sidebarPrimary: Color.lerp(sidebarPrimary, other.sidebarPrimary, t)!,
      sidebarPrimaryForeground: Color.lerp(sidebarPrimaryForeground, other.sidebarPrimaryForeground, t)!,
      sidebarAccent: Color.lerp(sidebarAccent, other.sidebarAccent, t)!,
      sidebarAccentForeground: Color.lerp(sidebarAccentForeground, other.sidebarAccentForeground, t)!,
      sidebarBorder: Color.lerp(sidebarBorder, other.sidebarBorder, t)!,
      sidebarRing: Color.lerp(sidebarRing, other.sidebarRing, t)!,
    );
  }
}

class AppTheme {
  // Tailwind Slate Palette (Restored for backward compatibility)
  static const slate50 = Color(0xFFF8FAFC);
  static const slate100 = Color(0xFFF1F5F9);
  static const slate200 = Color(0xFFE2E8F0);
  static const slate300 = Color(0xFFCBD5E1);
  static const slate400 = Color(0xFF94A3B8);
  static const slate500 = Color(0xFF64748B);
  static const slate600 = Color(0xFF475569);
  static const slate700 = Color(0xFF334155);
  static const slate800 = Color(0xFF1E293B);
  static const slate900 = Color(0xFF0F172A);
  static const slate950 = Color(0xFF020617);

  // Tailwind Blue Palette
  static const blue50 = Color(0xFFEFF6FF);
  static const blue100 = Color(0xFFDBEAFE);
  static const blue600 = Color(0xFF2563EB);
  static const blue700 = Color(0xFF1D4ED8);
  
  // Brand Colors
  static const brandPrimary = Color(0xFF030213);

  // Light Mode Colors (Converted from oklch/hex)
  static const _lightBackground = Color(0xFFFFFFFF);
  static const _lightForeground = Color(0xFF252525); // oklch(0.145 0 0)
  static const _lightCard = Color(0xFFFFFFFF);
  static const _lightCardForeground = Color(0xFF252525);
  static const _lightPopover = Color(0xFFFFFFFF); // oklch(1 0 0)
  static const _lightPopoverForeground = Color(0xFF252525);
  static const _lightPrimary = Color(0xFF030213);
  static const _lightPrimaryForeground = Color(0xFFFFFFFF); // oklch(1 0 0)
  static const _lightSecondary = Color(0xFFF2F4F7); // oklch(0.95 0.0058 264.53)
  static const _lightSecondaryForeground = Color(0xFF030213);
  static const _lightMuted = Color(0xFFECECF0);
  static const _lightMutedForeground = Color(0xFF717182);
  static const _lightAccent = Color(0xFFE9EBEF);
  static const _lightAccentForeground = Color(0xFF030213);
  static const _lightDestructive = Color(0xFFD4183D);
  static const _lightDestructiveForeground = Color(0xFFFFFFFF);
  static const _lightBorder = Color(0x1A000000); // rgba(0, 0, 0, 0.1)
  static const _lightInput = Color(0x00000000); // transparent
  static const _lightRing = Color(0xFFB5B5B5); // oklch(0.708 0 0)
  
  // Light Mode Charts
  static const _lightChart1 = Color(0xFFE76E50); // oklch(0.646 0.222 41.116)
  static const _lightChart2 = Color(0xFF2A9D8F); // oklch(0.6 0.118 184.704)
  static const _lightChart3 = Color(0xFF264653); // oklch(0.398 0.07 227.392)
  static const _lightChart4 = Color(0xFFE9C46A); // oklch(0.828 0.189 84.429)
  static const _lightChart5 = Color(0xFFF4A261); // oklch(0.769 0.188 70.08)

  // Light Mode Sidebar
  static const _lightSidebar = Color(0xFFFBFBFB); // oklch(0.985 0 0)
  static const _lightSidebarForeground = Color(0xFF252525); // oklch(0.145 0 0)
  static const _lightSidebarPrimary = Color(0xFF030213);
  static const _lightSidebarPrimaryForeground = Color(0xFFFBFBFB);
  static const _lightSidebarAccent = Color(0xFFF7F7F7); // oklch(0.97 0 0)
  static const _lightSidebarAccentForeground = Color(0xFF343434); // oklch(0.205 0 0)
  static const _lightSidebarBorder = Color(0xFFEBEBEB); // oklch(0.922 0 0)
  static const _lightSidebarRing = Color(0xFFB5B5B5); // oklch(0.708 0 0)


  // Dark Mode Colors (Converted from oklch/hex)
  static const _darkBackground = Color(0xFF252525); // oklch(0.145 0 0)
  static const _darkForeground = Color(0xFFFBFBFB); // oklch(0.985 0 0)
  static const _darkCard = Color(0xFF252525);
  static const _darkCardForeground = Color(0xFFFBFBFB);
  static const _darkPopover = Color(0xFF252525);
  static const _darkPopoverForeground = Color(0xFFFBFBFB);
  static const _darkPrimary = Color(0xFFFBFBFB); // oklch(0.985 0 0)
  static const _darkPrimaryForeground = Color(0xFF343434); // oklch(0.205 0 0)
  static const _darkSecondary = Color(0xFF454545); // oklch(0.269 0 0)
  static const _darkSecondaryForeground = Color(0xFFFBFBFB);
  static const _darkMuted = Color(0xFF454545);
  static const _darkMutedForeground = Color(0xFFB5B5B5); // oklch(0.708 0 0)
  static const _darkAccent = Color(0xFF454545);
  static const _darkAccentForeground = Color(0xFFFBFBFB);
  static const _darkDestructive = Color(0xFF991B1B); // oklch(0.396 0.141 25.723)
  static const _darkDestructiveForeground = Color(0xFFEF4444); // oklch(0.637 0.237 25.331)
  static const _darkBorder = Color(0xFF454545); // oklch(0.269 0 0)
  static const _darkInput = Color(0xFF454545);
  static const _darkRing = Color(0xFF707070); // oklch(0.439 0 0)

  // Dark Mode Charts
  static const _darkChart1 = Color(0xFF2A9D8F); // oklch(0.488 0.243 264.376)
  static const _darkChart2 = Color(0xFFE9C46A); // oklch(0.696 0.17 162.48)
  static const _darkChart3 = Color(0xFFF4A261); // oklch(0.769 0.188 70.08)
  static const _darkChart4 = Color(0xFFE76E50); // oklch(0.627 0.265 303.9)
  static const _darkChart5 = Color(0xFF264653); // oklch(0.645 0.246 16.439)

  // Dark Mode Sidebar
  static const _darkSidebar = Color(0xFF343434); // oklch(0.205 0 0)
  static const _darkSidebarForeground = Color(0xFFFBFBFB);
  static const _darkSidebarPrimary = Color(0xFF2A9D8F); // oklch(0.488 0.243 264.376)
  static const _darkSidebarPrimaryForeground = Color(0xFFFBFBFB);
  static const _darkSidebarAccent = Color(0xFF454545); // oklch(0.269 0 0)
  static const _darkSidebarAccentForeground = Color(0xFFFBFBFB);
  static const _darkSidebarBorder = Color(0xFF454545);
  static const _darkSidebarRing = Color(0xFF707070); // oklch(0.439 0 0)


  static const double _radius = 10.0; // 0.625rem

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: _lightBackground,
    colorScheme: const ColorScheme.light(
      primary: _lightPrimary,
      onPrimary: _lightPrimaryForeground,
      secondary: _lightSecondary,
      onSecondary: _lightSecondaryForeground,
      surface: _lightBackground,
      onSurface: _lightForeground,
      error: _lightDestructive,
      onError: _lightDestructiveForeground,
      outline: _lightBorder,
      outlineVariant: _lightMuted,
    ),
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: _lightForeground,
      displayColor: _lightForeground,
    ),
    cardTheme: const CardThemeData(
      color: _lightCard,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _lightBorder),
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: _lightBorder,
      thickness: 1,
    ),
    extensions: const [
      AppColors(
        chart1: _lightChart1,
        chart2: _lightChart2,
        chart3: _lightChart3,
        chart4: _lightChart4,
        chart5: _lightChart5,
        sidebarBackground: _lightSidebar,
        sidebarForeground: _lightSidebarForeground,
        sidebarPrimary: _lightSidebarPrimary,
        sidebarPrimaryForeground: _lightSidebarPrimaryForeground,
        sidebarAccent: _lightSidebarAccent,
        sidebarAccentForeground: _lightSidebarAccentForeground,
        sidebarBorder: _lightSidebarBorder,
        sidebarRing: _lightSidebarRing,
      ),
    ],
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimary,
      onPrimary: _darkPrimaryForeground,
      secondary: _darkSecondary,
      onSecondary: _darkSecondaryForeground,
      surface: _darkBackground,
      onSurface: _darkForeground,
      error: _darkDestructive,
      onError: _darkDestructiveForeground,
      outline: _darkBorder,
      outlineVariant: _darkMuted,
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: _darkForeground,
      displayColor: _darkForeground,
    ),
    cardTheme: const CardThemeData(
      color: _darkCard,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _darkBorder),
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: _darkBorder,
      thickness: 1,
    ),
    extensions: const [
      AppColors(
        chart1: _darkChart1,
        chart2: _darkChart2,
        chart3: _darkChart3,
        chart4: _darkChart4,
        chart5: _darkChart5,
        sidebarBackground: _darkSidebar,
        sidebarForeground: _darkSidebarForeground,
        sidebarPrimary: _darkSidebarPrimary,
        sidebarPrimaryForeground: _darkSidebarPrimaryForeground,
        sidebarAccent: _darkSidebarAccent,
        sidebarAccentForeground: _darkSidebarAccentForeground,
        sidebarBorder: _darkSidebarBorder,
        sidebarRing: _darkSidebarRing,
      ),
    ],
  );
}