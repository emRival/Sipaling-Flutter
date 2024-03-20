import 'package:flutter/material.dart';
import 'package:latihan_provider_add_list/provider/siswa_provider.dart';
import 'package:provider/provider.dart';

class SiswaListDone extends StatelessWidget {
  // final List<String> siswaListDone;
  const SiswaListDone({super.key});

  @override
  Widget build(BuildContext context) {
    // final siswaListDone =
    //     Provider.of<SiswaProvider>(context, listen: false).siswaListDone;

    // final bool isDone = siswaListDone
    return Scaffold(
      appBar: AppBar(
        title: Text("List Siswa Done"),
      ),
      body: Consumer(
        builder: (context, SiswaProvider data, widget) {
          return ListView.builder(
            itemCount: data.siswaListDone.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data.siswaListDone[index]),
                trailing: IconButton(
                    onPressed: () {
                      data.removeSiswaListDone(data.siswaListDone[index]);
                    },
                    icon: Icon(Icons.remove)),
              );
            },
          );
        },
      ),
    );
  }
}
