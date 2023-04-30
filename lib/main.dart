import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/common/splash-screen.dart';
import 'package:todo/common/style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedTheme = await AdaptiveTheme.getThemeMode();
  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');
  runApp(
    ProviderScope(
      child: MainApp(
        savedThemeMode: savedTheme,
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MainApp({
    Key? key,
    this.savedThemeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: blueC,
        canvasColor: blueC,
        shadowColor: darkC,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: blueC),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: darkC)
            .copyWith(
              bodyLarge: const TextStyle(
                color: darkC,
              ),
              bodyMedium: const TextStyle(
                color: darkC,
              ),
            ),
      ),
      dark: ThemeData(
        scaffoldBackgroundColor: darkC,
        primaryColor: blueC,
        canvasColor: blueC,
        shadowColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: blueC),
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
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, dark) {
        return MaterialApp(
          title: 'Yo, Chill!',
          theme: theme,
          darkTheme: dark,
          debugShowCheckedModeBanner: false,
          home: const SafeArea(
            child: SplashScreen(),
          ),
        );
      },
    );
  }
}
