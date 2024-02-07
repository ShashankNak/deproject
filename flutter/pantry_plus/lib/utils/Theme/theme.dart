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

TextTheme customTextTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

ColorScheme customColorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}
