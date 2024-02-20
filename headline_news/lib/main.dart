import 'package:flutter/material.dart';
import 'package:headline_news/models/news_channel_headlines_model.dart';
import 'package:headline_news/pages/categorys_page.dart';
import 'package:headline_news/pages/detail_page.dart';
import 'package:headline_news/pages/main_page.dart';
import 'package:headline_news/pages/splash_screen.dart';
import 'package:headline_news/pages/webview.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(backgroundColor: Colors.white, primarySwatch: Colors.amber),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        MainPage.routeName: (context) => const MainPage(),
        CategorysPage.routeName: (context) => const CategorysPage(),
        DetailPage.routeName:(context) => DetailPage(news: ModalRoute.of(context)?.settings.arguments as Articles),
        WebView.routeName:(context) => WebView(url: ModalRoute.of(context)?.settings.arguments as String)
      },
    );
  }
}
