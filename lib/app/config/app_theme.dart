import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFFFFEA00);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xff8d8d8d);
  static const onPrimaryContainer = Color(0xff4b4b4b);
  static const secondary = Color(0xff343C45);
  static const onSurface = Color(0xFFFFFFFF);
  static const tertiary = Color(0xFF000000);
  static const onTertiary = Color(0xFFFFFFFF);

  static const double textInputRadius = 16;

  static TextStyle _customTextStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? GoogleFonts.mavenPro().fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? onSurface,
    );
  }

  static ThemeData appThemeLight() {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        tertiary: tertiary,
        onTertiary: onTertiary,
        onSurface: onSurface,
        shadow: Color(0xffF5F6F7),
      ),
      scaffoldBackgroundColor: tertiary,
      textTheme: GoogleFonts.montserratTextTheme(
        ThemeData.light().textTheme.copyWith(
              // headline
              headlineLarge: _customTextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
              headlineMedium: _customTextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 28,
              ),
              headlineSmall: _customTextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),

              // title
              titleLarge: _customTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              titleMedium: _customTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              titleSmall: GoogleFonts.mukta(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),

              // body
              bodyLarge: _customTextStyle(
                fontSize: 16,
              ),
              bodyMedium: _customTextStyle(
                fontSize: 14,
              ),
              bodySmall: _customTextStyle(
                fontSize: 12,
              ),

              // label
              labelLarge: _customTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              labelMedium: _customTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.interTextTheme.toString(),
                color: onTertiary,
              ),
              labelSmall: _customTextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
      ),

      /// input style
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        hintStyle: TextStyle(color: primaryContainer),
        fillColor: onPrimary,
        contentPadding:
            EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(textInputRadius)),
          borderSide: BorderSide(color: tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(textInputRadius)),
          borderSide: BorderSide(color: tertiary),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(textInputRadius)),
          borderSide: BorderSide(color: tertiary),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(textInputRadius)),
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(textInputRadius)),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
