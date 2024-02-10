import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _myNumber = 0;

  void _tambah() {
    setState(() {
      _myNumber += 1;
    });
  }

  void _kurang() {
    setState(() {
      _myNumber -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello World :)"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Kamu Telah menekan tombol Sebanyak"),
            Text(
              _myNumber.toString(),
              style: const TextStyle(fontSize: 160),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _tambah,
                  label: const Text("Tambah"),
                  icon: const Icon(Icons.add),
                ),
                ElevatedButton.icon(
                  onPressed: _myNumber > 0 ? _kurang : null,
                  label: const Text("Kurang"),
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
