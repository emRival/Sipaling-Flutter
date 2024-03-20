import 'package:flutter/material.dart';
import 'package:latihan_provider_add_list/provider/siswa_provider.dart';
import 'package:latihan_provider_add_list/ui/siswa_tile.dart';
import 'package:provider/provider.dart';

class SiswaList extends StatelessWidget {
  // final List<String> siswaListDone;
  // final List<String> siswaList;

  SiswaList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, SiswaProvider data, widget) {
      return ListView.builder(
          itemCount: data.siswaList.length,
          itemBuilder: (context, index) {
            return SiswaTile(
              siswaName: data.siswaList[index],
              isDone: data.siswaListDone.contains(data.siswaList[index]),
              onClick: () {
                data.addSiswaListDone(data.siswaList[index]);
              },
            );
          });
    });
  }
}
