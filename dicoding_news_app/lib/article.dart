import 'dart:convert';

class Article {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  //ubah map ke objek

  factory Article.fromJson(Map<String, dynamic> article) => Article(
        author: article['author'],
        title: article['title'],
        description: article['description'],
        url: article['url'],
        urlToImage: article['urlToImage'],
        publishedAt: article['publishedAt'],
        content: article['content'],
      );

      
}

/*
Fungsi parseArticles: Fungsi ini menerima string JSON sebagai input, mengonversinya menjadi list Dart, dan kemudian mengonversi setiap elemen list menjadi objek Article menggunakan metode fromJson. Hasilnya adalah list objek Article.
*/

List<Article> parseArticles(String? json) {
  if (json == null) { 
      return [];
  }
 
  final List parsed = jsonDecode(json);
  return parsed.map((json) => Article.fromJson(json)).toList();
}
