import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quran_app/model/ayah_model.dart';
import 'package:quran_app/model/surah_model.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class QuranRepository {
  Future<List<Surah>> getListSurah() async {
    String data = await rootBundle.loadString('assets/data/list-surah.json');

    return surahFromJson(data);
  }

  Future<AyahModel> getListAyah(String idSurah) async {
    String url = 'https://equran.id/api/surat/$idSurah';

    final cacheAyah = Hive.box('ayah_data').get(idSurah, defaultValue: null);
    if (cacheAyah != null && cacheAyah is Map<String, dynamic>) {
      print("data offline tersedia");
      return AyahModel.fromJson(cacheAyah);
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      Hive.box('ayah_data').put(idSurah, body);
      return AyahModel.fromJson(body);
    } else {
      throw Exception("Failed to load ayah list");
    }
  }
}
