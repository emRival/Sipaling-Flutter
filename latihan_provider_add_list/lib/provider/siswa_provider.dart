import 'package:flutter/material.dart';

class SiswaProvider extends ChangeNotifier {
  final List<String> _siswaListDone = [];
  final List<String> _siswaList = ['Muhammad Rival', 'aisy afrah'];

  List<String> get siswaListDone => _siswaListDone;
  List<String> get siswaList => _siswaList;

  void addSiswaListDone(String siswaName) {
    _siswaListDone.add(siswaName);
    notifyListeners();
  }

    void removeSiswaListDone(String siswaName) {
    _siswaListDone.remove(siswaName);
    notifyListeners();
  }

  void addSiswaList(String siswaName) {
    _siswaList.add(siswaName);
    notifyListeners();
  }
}
