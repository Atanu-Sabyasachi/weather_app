import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_design/home_screen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color.fromARGB(146, 51, 48, 55),
      statusBarColor: Colors.white,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> materialAppKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Montserrat",
      ),
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.system,
      home: const Homescreen(),
    );
  }
}
