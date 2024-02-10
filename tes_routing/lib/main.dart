import 'package:flutter/material.dart';
import 'package:tes_routing/first_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     theme: ThemeData(
      primarySwatch: Colors.amber,
      visualDensity: VisualDensity.adaptivePlatformDensity
     ),
     initialRoute: '/',
     routes: {
      '/': (context) => FirstScreen()
     },

    );
  }
}
