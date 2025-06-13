import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static const Color primary = Color(0xFFFFEA00);
  static const Color onPrimary = Color(0xFF000000);
  static const secondary = Color(0xff8d8d8d);
  static const onSecondary = Color(0xffffffff);
  static const backgroundColor = Color(0xff000000);
  static const onBackgroundColor = Color(0xfffdfdfd);
  static const surface = Color(0xff343C45);
  static const onSurface = Color(0xFFFFFFFF);
  static const tertiary = Color(0xff555559);
  static const Color red = Color(0xFFFF0008);
  static const Color green = Color(0xFF00BD31);
  static const Color orange = Color(0xFFFF8000);


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
        tertiary: tertiary,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        surface: surface,
        onSurface: onSurface,
        shadow: Color(0xffF5F6F7),
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: GoogleFonts.montserratTextTheme(
        ThemeData.light().textTheme.copyWith(
              // headline
              headlineLarge: _customTextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
              headlineMedium: _customTextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
              headlineSmall: _customTextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),

              // title
              titleLarge: _customTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
              titleMedium: _customTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
              titleSmall: _customTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
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
                fontWeight: FontWeight.w700,
                fontFamily: GoogleFonts.interTextTheme.toString(),
              ),
              labelSmall: _customTextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
      ),

      /// input style
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        hintStyle: TextStyle(color: secondary),
        // fillColor: onPrimary,
        contentPadding:
            EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(textInputRadius)),
          borderSide: BorderSide(color: onSecondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(textInputRadius)),
          borderSide: BorderSide(color: onSecondary),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(textInputRadius)),
          borderSide: BorderSide(color: onSecondary),
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
