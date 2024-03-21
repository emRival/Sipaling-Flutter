import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/model/ayah_model.dart';
import 'package:quran_app/viewmodel/ayah_viewmodel.dart';

enum ResultState { loading, noData, hasData, error }

class QuranProvider extends ChangeNotifier {
  final AyahViewModel ayahViewModel = AyahViewModel();
  final String id_surah;

  QuranProvider({required this.id_surah}) {
    _fetchAllAyah(id: id_surah);
  }

  late AyahModel _ayahsResult;


  late ResultState _state;
  String _message = '';

  String get message => _message;

  AyahModel get result => _ayahsResult;

  List<Ayat>? get ayat => _ayahsResult.ayat;

  ResultState get state => _state;



  ConnectionState _connectionState = ConnectionState.none;

  ConnectionState get connectionState => _connectionState;

  Future<void> _fetchAllAyah({required String id}) async {
    try {
      _connectionState = ConnectionState.waiting;
      notifyListeners();
      final ayah = await ayahViewModel.getListAyah(id);
      if (ayah.ayat!.isEmpty) {
        _connectionState = ConnectionState.done;
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _connectionState = ConnectionState.done;
        _state = ResultState.hasData;
        notifyListeners();
        _ayahsResult = ayah;
      }
    } catch (e) {
      _connectionState = ConnectionState.done;
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error --> $e';
    }
  }

  void onRetry() {
    _fetchAllAyah(id: id_surah);
  }

  String? getAudioFullLink(String selectedAudioSource) {
    switch (selectedAudioSource) {
      case '01':
        return _ayahsResult.audioFull?.s01?.toString();
      case '02':
        return _ayahsResult.audioFull?.s02?.toString();
      case '03':
        return _ayahsResult.audioFull?.s03?.toString();
      case '04':
        return _ayahsResult.audioFull?.s04?.toString();
      case '05':
        return _ayahsResult.audioFull?.s05?.toString();
      // Add cases for other audio sources as needed
      default:
        // Handle the default case, maybe set link to a default value or show an error message
        return null;
    }
  }

   String? getAudioAyatLink(String selectedAudioSource, Ayat ayat) {
    switch (selectedAudioSource) {
      case '01':
        return ayat.audio!.s01.toString();
      case '02':
        return ayat.audio!.s02.toString();
      case '03':
        return ayat.audio!.s03?.toString();
      case '04':
        return ayat.audio!.s04?.toString();
      case '05':
        return ayat.audio!.s05?.toString();
      // Add cases for other audio sources as needed
      default:
        // Handle the default case, maybe set link to a default value or show an error message
        return null;
    }
  }

  Future<void> setupAudioPlayer(
      {required AudioPlayer player, required String link}) async {
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stacktrace) {
      print("A Stream Error Occurred: $e");
    });
    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(link)));
    } catch (e) {
      print("Error Loading Audio Source: $e");
    }
  }
}
