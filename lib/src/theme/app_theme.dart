import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Tailwind Slate Palette
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

  // Tailwind Blue Palette (for links/active states)
  static const blue50 = Color(0xFFEFF6FF);
  static const blue100 = Color(0xFFDBEAFE);
  static const blue600 = Color(0xFF2563EB);
  static const blue700 = Color(0xFF1D4ED8);

  // Brand Colors from CSS
  static const brandPrimary = Color(0xFF030213);
  static const brandDestructive = Color(0xFFD4183D);

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: brandPrimary,
      onPrimary: Colors.white,
      secondary: slate100, // --secondary
      onSecondary: brandPrimary,
      surface: Colors.white,
      onSurface: slate900, // --foreground
      error: brandDestructive,
      onError: Colors.white,
      outline: Color(0x1A000000), // --border
      outlineVariant: slate200,
    ),
    scaffoldBackgroundColor: Colors.white, // --background
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: slate900,
      displayColor: slate900,
    ),
    cardTheme: const CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0x1A000000)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: slate200,
      thickness: 1,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white, // --primary
      onPrimary: slate900, // --primary-foreground
      secondary: slate800, // --secondary
      onSecondary: Colors.white,
      surface: slate900, // --background
      onSurface: Colors.white, // --foreground
      error: Color(0xFF7F1D1D),
      onError: Colors.white,
      outline: slate800, // --border
      outlineVariant: slate700,
    ),
    scaffoldBackgroundColor: slate900,
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    cardTheme: const CardThemeData(
      color: slate900, // --card
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: slate800),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: slate800,
      thickness: 1,
    ),
  );
}
