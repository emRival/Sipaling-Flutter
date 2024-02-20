import 'package:headline_news/models/news_channel_headlines_model.dart';
import 'package:headline_news/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepositroy();

  Future<NewsChannelHeadlineModel> fetchNewChannelHeadlinesApi(String channelName) async {
    try {
      final response = await _repo.fetchNewsChannelHeadlinesApi(channelName);
      return response;
    } catch (e) {
      // Handle error
      print("Error fetching news channel headlines: $e");
      rethrow; // Rethrow the error so it can be caught by the caller if needed
    }
  }

  Future<NewsChannelHeadlineModel> fetchNewsCategoryApi(String category) async {
    try {
      final response = await _repo.fetchNewsCategoryApi(category);
      return response;
    } catch (e) {
      // Handle error
      print("Error fetching news category: $e");
      rethrow; // Rethrow the error so it can be caught by the caller if needed
    }
  }
}
