import 'package:flutter/material.dart';

class AddSiswa extends StatelessWidget {
  // final List<String> siswaList;
  final Function(String) onClick;
  AddSiswa({super.key, required this.onClick});

  final TextEditingController _namaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
          ),
          IconButton(
            onPressed: () {
              onClick(_namaController.text);
              _namaController.clear();
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
