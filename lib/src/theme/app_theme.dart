import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF030213),
      onPrimary: Colors.white,
      secondary: Color(0xFFF1F5F9), // Approx for oklch(0.95 0.0058 264.53)
      onSecondary: Color(0xFF030213),
      surface: Colors.white,
      onSurface: Color(0xFF0F172A), // Approx for oklch(0.145 0 0)
      error: Color(0xFFD4183D),
      onError: Colors.white,
      outline: Color(0x1A000000), // border: rgba(0, 0, 0, 0.1)
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.interTextTheme(),
    cardTheme: const CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0x1A000000)), // border color
        borderRadius: BorderRadius.all(Radius.circular(10)), // radius: 0.625rem ~= 10px
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white, // --primary: oklch(0.985 0 0)
      onPrimary: Color(0xFF0F172A), // --primary-foreground: oklch(0.205 0 0)
      secondary: Color(0xFF1E293B), // --secondary: oklch(0.269 0 0)
      onSecondary: Colors.white,
      surface: Color(0xFF0F172A), // --background: oklch(0.145 0 0)
      onSurface: Colors.white,
      error: Color(0xFF7F1D1D), // --destructive dark approx
      onError: Colors.white,
      outline: Color(0xFF1E293B), // --border dark
    ),
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    cardTheme: const CardThemeData(
      color: Color(0xFF0F172A),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFF1E293B)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}
