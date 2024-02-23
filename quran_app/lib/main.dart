import 'package:flutter/material.dart';
import 'package:quran_app/pages/detail_screen1.dart';
import 'package:quran_app/pages/home_screen.dart';
import 'package:quran_app/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailScreen1.routeName:(context) => DetailScreen1(id_surah: ModalRoute.of(context)?.settings.arguments as String)
      },
    );
  }
}
