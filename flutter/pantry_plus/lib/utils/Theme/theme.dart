import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.caveatBrushTextTheme(),
  colorScheme: const ColorScheme.light(
    background: Color.fromRGBO(255, 244, 231, 1),
    onBackground: Colors.black,
    primary: Color.fromRGBO(255, 103, 91, 1),
    onPrimary: Colors.white,
  ),
);

ThemeData darktheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.caveatBrushTextTheme(),
  colorScheme: const ColorScheme.dark(
      background: Color.fromRGBO(0, 0, 0, 1),
      onBackground: Color.fromARGB(255, 255, 255, 255),
      primary: Color.fromRGBO(1, 59, 46, 1),
      onPrimary: Colors.white,
      secondary: Color.fromARGB(255, 37, 120, 106),
      onSecondary: Colors.white),
);

TextTheme customTextTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

ColorScheme customColorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}
