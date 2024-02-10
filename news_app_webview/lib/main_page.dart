import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:news_app_webview/articles.dart';
import 'package:news_app_webview/detail_page.dart';

class MainPage extends StatelessWidget {
  static const routeName = '/main_page';
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString('assets/articles.json'),
          builder: (context, snapshot) {
            final List<Articles> articles = parsedArticles(snapshot.data);
            return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return _buildArticleItem(context, articles[index]);
                });
          }),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Articles articles) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: SizedBox(
      width: 100,
      child: Image.network(
        articles.urlToImage,
        errorBuilder: (ctx, error, _) => const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
            ),
            Text(
              "Error Load Image",
              style: TextStyle(
                  fontSize: 9, fontWeight: FontWeight.w300, color: Colors.red),
            )
          ],
        )),
      ),
    ),
    title: Text(articles.title),
    subtitle: Text(articles.author),
    onTap: () {
      Navigator.pushNamed(context, DetailPage.routeName, arguments: articles);
    },
  );
}
