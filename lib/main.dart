import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/home/home_screen.dart';
import 'package:movies_app/ui/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: SplashScreen.routeName,

      routes: {
        SplashScreen.routeName : (_) => SplashScreen(),
        HomeScreen.routeName : (_) => HomeScreen()
      },
    );
  }
}