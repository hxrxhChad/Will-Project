import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/screens/home/kHome.dart';
import 'package:todo/service/custom/style.dart';
import 'package:todo/service/model/notes-model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerAdapters();
  await Hive.initFlutter();
  var box = await Hive.openBox('app');

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Set status bar color to transparent
    statusBarBrightness: Brightness.light, // Set status bar brightness
    systemNavigationBarColor:
        dark, // Set system navigation bar color to transparent
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(
    MainApp(),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yo, Chill!',
      theme: theme(context),
      debugShowCheckedModeBanner: false,
      home: kHome(),
    );
  }
}
