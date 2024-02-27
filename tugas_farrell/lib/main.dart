import 'package:flutter/material.dart';
import 'package:tugas_farrell/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
          initialRoute: HomeScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
          },
    );
  }
}
