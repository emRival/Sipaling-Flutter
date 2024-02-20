import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'detail_screen';
  final int id_surah;
  const DetailScreen({super.key, required this.id_surah});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text(id_surah.toString()));
  }
}
