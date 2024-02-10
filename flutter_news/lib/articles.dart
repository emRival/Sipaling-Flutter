import 'dart:convert';

class Articles {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Articles({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  // untuk mengubah data map ke objek

  factory Articles.fromJson(Map<String, dynamic> article) => Articles(
      author: article['author'],
      title: article['title'],
      description: article['description'],
      url: article['url'],
      urlToImage: article['urlToImage'],
      publishedAt: article['publishedAt'],
      content: article['content']);
}

List<Articles> parseArticles(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Articles.fromJson(json)).toList();
}
