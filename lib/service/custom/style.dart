import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// colors
const dark = Color(0xff040405);
const orange = Color(0xffff7c17);
const blue = Color(0xff1557ff);
const purple = Color(0xff7371ff);
const darkBlue = Color(0xff1c233c);
const dark2 = Color(0xff21262d);

// theme
theme(context) {
  return ThemeData(
    scaffoldBackgroundColor: dark,
    primaryColor: dark2,
    canvasColor: dark2,
    shadowColor: Colors.white,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: dark2),
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: Colors.white)
        .copyWith(
          bodyLarge: const TextStyle(
            color: Colors.white,
          ),
          bodyMedium: const TextStyle(
            color: Colors.white,
          ),
        ),
  );
}

// text style
TextStyle style(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .headlineSmall!
      .copyWith(fontSize: kPad(context) * 0.05, fontWeight: FontWeight.w400);
}

// padding
double kPad(context) {
  return MediaQuery.of(context).size.width;
}
