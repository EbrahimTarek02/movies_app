import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/home/home_screen.dart';
import 'package:movies_app/ui/util/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, HomeScreen.routeName)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.splash,
      fit: BoxFit.cover,
    );
  }
}