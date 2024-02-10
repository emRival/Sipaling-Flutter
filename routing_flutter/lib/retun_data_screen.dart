import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReturnDataScreen extends StatelessWidget {
  final _dataName = TextEditingController();
  final _dataAge = TextEditingController();
  final _dataAddress = TextEditingController();
  ReturnDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Return data Screen"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _dataName,
                decoration:
                    const InputDecoration(labelText: "Masukkan Nama Anda"),
              ),
              TextField(
                controller: _dataAge,
                decoration:
                    const InputDecoration(labelText: "Masukkan Umur Anda"),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              TextField(
                controller: _dataAddress,
                decoration:
                    const InputDecoration(labelText: "Masukkan Alamat Anda"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_dataName.text.isEmpty ||
                        _dataAge.text.isEmpty ||
                        _dataAddress.text.isEmpty) {
                      Navigator.pop(context, null);
                    } else {
                      final dataMap = {
                        'name': _dataName.text,
                        'age': _dataAge.text,
                        'address': _dataAddress.text
                      };
                      Navigator.pop(context, dataMap);
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
