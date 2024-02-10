import 'package:flutter/material.dart';
import 'package:routing_flutter/first_page.dart';
import 'package:routing_flutter/last_page.dart';
import 'package:routing_flutter/main_page.dart';
import 'package:routing_flutter/move_with_data.dart';
import 'package:routing_flutter/replace_page.dart';
import 'package:routing_flutter/retun_data_screen.dart';
import 'package:routing_flutter/secound_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber,
        appBarTheme: const AppBarTheme(
          color: Colors.amber,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black26),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/ind': (context) => const FirstPage(),
        '/pbtn': (context) => const SecoundPage(),
        '/mwd': (context) =>
            MoveWithData(ModalRoute.of(context)?.settings.arguments as String),
        '/rds': (context) => ReturnDataScreen(),
        '/rp': (context) => const ReplacePage(),
        '/lp': (context) => const LastPage(),
      },
    );
  }
}
