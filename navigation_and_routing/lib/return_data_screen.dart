import 'package:flutter/material.dart';

class ReturnDataScreen extends StatefulWidget {
  const ReturnDataScreen({super.key});

  @override
  State<ReturnDataScreen> createState() => _ReturnDataScreenState();
}

class _ReturnDataScreenState extends State<ReturnDataScreen> {
  final _textController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _textController,
                    decoration:
                        const InputDecoration(labelText: "Enter Your Name"),
                  ),
                  TextField(
                    controller: _ageController,
                    decoration:
                        const InputDecoration(labelText: "Enter Your Age"),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final Map<String, dynamic> data = {
                  'name' : _textController.text,
                  'age': _ageController.text
                };
                Navigator.pop(context, data);
              },
              child: Text('back'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _ageController.dispose();
    super.dispose();
  }
}
