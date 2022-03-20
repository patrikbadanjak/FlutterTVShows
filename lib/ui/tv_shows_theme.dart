import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TVShowsTheme {
  static TextTheme lightTextTheme = const TextTheme().copyWith(
    headline1: GoogleFonts.roboto(
      fontSize: 36.0,
      fontWeight: FontWeight.w700,
      color: const Color(0xDE000000),
    ),
    headline6: GoogleFonts.roboto(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: const Color(0xDE000000),
    ),
    button: GoogleFonts.roboto(
      fontSize: 17.0,
      fontWeight: FontWeight.w700,
      color: const Color(0xFFFFFFFF),
    ),
    bodyText1: GoogleFonts.roboto(
      fontSize: 17.0,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF000000),
    ),
    bodyText2: GoogleFonts.roboto(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: const Color(0x99000000),
    ),
  );

  static ThemeData light() {
    return ThemeData().copyWith(
      primaryTextTheme: lightTextTheme,
      primaryColor: const Color(0xFF52368C),
      primaryColorDark: const Color(0xFF3D1D72),
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        titleTextStyle: lightTextTheme.headline1,
        elevation: 0.0,
      ),
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF52368C)),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(45.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          elevation: MaterialStateProperty.all(0.0),
          alignment: Alignment.center,
          textStyle: MaterialStateProperty.all(lightTextTheme.button),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
          ),
        ),
      ),
    );
  }
}
