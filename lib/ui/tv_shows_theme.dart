import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TVShowsTheme {
  static TextTheme lightTextTheme = const TextTheme().copyWith(
    headline1: GoogleFonts.roboto(
      fontSize: 36.0,
      fontWeight: FontWeight.w700,
      color: const Color(0xDE000000),
    ),
    headline5: GoogleFonts.roboto(
      fontSize: 24.0,
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
        toolbarHeight: 75.0,
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
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(const Color(0xFF52368C)),
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(45.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          side: MaterialStateProperty.all(
            const BorderSide(
              color: Color(0xFF52368C),
              width: 2.0,
            ),
          ),
          elevation: MaterialStateProperty.all(0.0),
          alignment: Alignment.center,
          textStyle: MaterialStateProperty.all(lightTextTheme.button),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          textStyle: MaterialStateProperty.all(
            lightTextTheme.bodyText1?.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
