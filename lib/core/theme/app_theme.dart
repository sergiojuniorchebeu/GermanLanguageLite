import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  // ── Thème clair ────────────────────────────────────────────────────────────
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: kScaffold,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: kBlue,
        onPrimary: Colors.white,
        primaryContainer: kBlueLight,
        onPrimaryContainer: kInk900,
        secondary: kGreen,
        onSecondary: Colors.white,
        secondaryContainer: kGreenLight,
        onSecondaryContainer: kInk900,
        tertiary: kPurple,
        onTertiary: Colors.white,
        tertiaryContainer: kPurpleLight,
        onTertiaryContainer: kInk900,
        error: kCoral,
        onError: Colors.white,
        errorContainer: kCoralLight,
        onErrorContainer: kInk900,
        surface: Colors.white,
        onSurface: kInk900,
        surfaceContainerHighest: kInk100,
        onSurfaceVariant: kInk600,
        outline: kBorder,
        outlineVariant: kBorder,
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: kInk900,
        onInverseSurface: Colors.white,
        inversePrimary: kBlueLight,
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: kScaffold,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(color: kInk800, size: 22),
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: kInk900,
        ),
        centerTitle: true,
      ),

      // Boutons principaux
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),

      // Boutons texte
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kBlue,
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kBlue, width: 1.5),
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: kInk500,
          fontSize: 14,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        isDense: false,
      ),

      // Dividers
      dividerTheme: const DividerThemeData(
        color: kBorder,
        thickness: 1,
        space: 0,
      ),

      // Drawer
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: kBlue,
        unselectedItemColor: kInk500,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: kBlue,
        linearTrackColor: kBlueLight,
        circularTrackColor: kBlueLight,
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: kInk100,
        selectedColor: kBlueLight,
        side: const BorderSide(color: kBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          color: kInk700,
        ),
      ),
    );
  }

  // ── Thème sombre ───────────────────────────────────────────────────────────
  static ThemeData get dark {
    const darkSurface = Color(0xFF1F2937);
    const darkBackground = Color(0xFF111827);
    const darkBorder = Color(0xFF374151);

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: darkBackground,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: kBlue,
        onPrimary: Colors.white,
        primaryContainer: const Color(0xFF1E3A5F),
        onPrimaryContainer: Colors.white,
        secondary: kGreen,
        onSecondary: Colors.white,
        secondaryContainer: const Color(0xFF1A3D30),
        onSecondaryContainer: Colors.white,
        tertiary: kPurple,
        onTertiary: Colors.white,
        tertiaryContainer: const Color(0xFF2D2456),
        onTertiaryContainer: Colors.white,
        error: kCoral,
        onError: Colors.white,
        errorContainer: const Color(0xFF4A1515),
        onErrorContainer: Colors.white,
        surface: darkSurface,
        onSurface: Colors.white,
        surfaceContainerHighest: const Color(0xFF2D3748),
        onSurfaceVariant: const Color(0xFF9CA3AF),
        outline: darkBorder,
        outlineVariant: darkBorder,
        shadow: Colors.black,
        scrim: Colors.black,
        inverseSurface: Colors.white,
        onInverseSurface: kInk900,
        inversePrimary: kBlue,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 22),
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
    );
  }
}
