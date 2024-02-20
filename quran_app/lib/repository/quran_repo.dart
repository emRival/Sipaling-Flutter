import 'package:flutter/services.dart';
import 'package:quran_app/model/surah_model.dart';

class QuranRepository {

  Future<List<Surah>> getListSurah() async {
    String data = await rootBundle.loadString('assets/data/list-surah.json');

    return surahFromJson(data);
  }
  
}
