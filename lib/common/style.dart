import 'package:flutter/material.dart';

// white color
const whiteC = Color(0xffd1d1d1);
// grey color
const grey1 = Color(0xffa4a4a4);
const grey2 = Color(0xff4e586e);
// purple color
const purp1 = Color(0xff463c64);
const purp2 = Color(0xff181830);
const purp3 = Color(0xff191724);
const darkC = Color(0xff0a090e);
// light-color
const pink1 = Color(0xffe53d8b);
const blue1 = Color(0xff2498de);
const blue2 = Color(0xff07b4f0);
const blueC = Color(0xff90bcf4);

// constant colors
Color primaryColor(BuildContext context) {
  return Theme.of(context).primaryColor;
}

Color scaffoldColor(BuildContext context) {
  return Theme.of(context).scaffoldBackgroundColor;
}

Color shadowColor(BuildContext context) {
  return Theme.of(context).shadowColor;
}

// constant text style
TextStyle style(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .headlineSmall!
      .copyWith(fontSize: 16, fontWeight: FontWeight.w400);
}

/*


---- theme changing function ---->
AdaptiveTheme.of(context).toggleThemeMode();

---- shared preferences setter ---->
SharedPreferences pref = await SharedPreferences.getInstance();
pref.setString("email", email);

---- shared preferences getter ---->
SharedPreferences pref = await SharedPreferences.getInstance();
pref.remove("email");


*/
