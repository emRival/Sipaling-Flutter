import 'package:flutter/material.dart';
import 'package:news_app_webview/articles.dart';
import 'package:news_app_webview/detail_page.dart';
import 'package:news_app_webview/main_page.dart';
import 'package:news_app_webview/webview_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: MainPage.routeName,
      routes: {
        MainPage.routeName: (context) => const MainPage(),
        DetailPage.routeName: (context) => DetailPage(
            article: ModalRoute.of(context)?.settings.arguments as Articles),
        WebViewPage.routeName: (context) => WebViewPage(
            url: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
