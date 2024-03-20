import 'package:flutter/material.dart';
import 'package:latihan_provider_add_list/provider/siswa_provider.dart';
import 'package:latihan_provider_add_list/ui/page_siswa.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => SiswaProvider(),
      child: MaterialApp(home: SiswaPage()));
  }
}
