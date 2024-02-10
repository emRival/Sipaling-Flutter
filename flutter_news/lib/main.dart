import 'package:flutter/material.dart';
import 'package:flutter_news/main_page.dart';

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
      initialRoute: MainPage.routeName,
      routes: {
        MainPage.routeName:(context) => const MainPage(),
      },
    );
  }
}
