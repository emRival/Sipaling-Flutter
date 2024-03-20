import 'package:flutter/material.dart';
import 'package:latihan_provider_add_list/provider/siswa_provider.dart';
import 'package:latihan_provider_add_list/ui/add_siswa.dart';
import 'package:latihan_provider_add_list/ui/siswa_list.dart';
import 'package:latihan_provider_add_list/ui/siswa_list_done.dart';
import 'package:provider/provider.dart';

class SiswaPage extends StatelessWidget {
  SiswaPage({super.key});

  // final List<String> siswaListDone = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Tugas Siswa"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SiswaListDone(
                  
                      ),
                    ),
                  ),
              icon: const Icon(Icons.done))
        ],
      ),
      body: Column(
        children: [
          Consumer(builder: (context, SiswaProvider data, widget){
            return AddSiswa(
              onClick: (String siswaName) {

                data.addSiswaList(siswaName);
               
              });
          }),
          
          Expanded(
            child: SiswaList(
            
            ),
          ),
        ],
      ),
    );
  }
}
