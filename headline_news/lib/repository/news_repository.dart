import 'dart:convert';
import 'package:headline_news/models/news_channel_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepositroy {
  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadlinesApi(
      String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=2a36e09e66604c79991dd3f1d32272a7';

    final response = await http.get(Uri.parse(url));
    

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlineModel.fromJson(body);
    }
    throw Exception("Error");
  }

  Future<NewsChannelHeadlineModel> fetchNewsCategoryApi(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=2a36e09e66604c79991dd3f1d32272a7';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlineModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
