import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: kScaffold,
      colorScheme: const ColorScheme(
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
        surface: kSurface,
        onSurface: kInk900,
        surfaceContainerHighest: kSurfaceMuted,
        onSurfaceVariant: kInk600,
        outline: kBorder,
        outlineVariant: kBorder,
        shadow: kShadow,
        scrim: Colors.black,
        inverseSurface: kInk900,
        onInverseSurface: Colors.white,
        inversePrimary: kBlueLight,
      ),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kInk900,
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: kSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kBlue, width: 1.5),
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: kInk500,
          fontSize: 14,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        isDense: false,
      ),
      dividerTheme: const DividerThemeData(
        color: kBorder,
        thickness: 1,
        space: 0,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: kSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: kSurface,
        selectedItemColor: kBlue,
        unselectedItemColor: kInk500,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: kGreen,
        linearTrackColor: kInk100,
        circularTrackColor: kInk100,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: kSurfaceMuted,
        selectedColor: kBlueLight,
        side: const BorderSide(color: kBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          color: kInk700,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: kSurface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: kBorder),
        ),
      ),
    );
  }

  static ThemeData get dark {
    const darkSurface = Color(0xFF1D1815);
    const darkBackground = Color(0xFF120F0D);
    const darkBorder = Color(0xFF3B312A);

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: darkBackground,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: kBlue,
        onPrimary: Colors.white,
        primaryContainer: Color(0xFF1E3A5F),
        onPrimaryContainer: Colors.white,
        secondary: kGreen,
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFF1A3D30),
        onSecondaryContainer: Colors.white,
        tertiary: kPurple,
        onTertiary: Colors.white,
        tertiaryContainer: Color(0xFF2D2456),
        onTertiaryContainer: Colors.white,
        error: kCoral,
        onError: Colors.white,
        errorContainer: Color(0xFF4A1515),
        onErrorContainer: Colors.white,
        surface: darkSurface,
        onSurface: Colors.white,
        surfaceContainerHighest: Color(0xFF2D3748),
        onSurfaceVariant: Color(0xFF9CA3AF),
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
