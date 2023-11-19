import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/category/category_screen.dart';
import 'package:movies_app/ui/screens/main/main_screen.dart';
import 'package:movies_app/ui/screens/movie_details/movie_details.dart';
import 'package:movies_app/ui/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.disableNetwork();
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
        SplashScreen.routeName: (_) => const SplashScreen(),
        MainScreen.routeName: (_) => const MainScreen(),
        MovieDetails.routeName: (_) => const MovieDetails(),
        CategoryScreen.routeName: (_) => const CategoryScreen(),
      },
    );
  }
}
