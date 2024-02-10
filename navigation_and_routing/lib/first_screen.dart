import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation & Routing"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/secondScreen');
              },
              child: const Text("Go to Second Screen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/secondScreenWithData',
                    arguments: 'Hello from First Screen!');
              },
              child: const Text("Navigation with Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final result =
                    await Navigator.pushNamed(context, '/returnDataScreen');

                if (result != null && result is Map<String, dynamic>) {
                  final dynamic name = result['name'];
                  final dynamic age = result['age'];

                  if (name != null && age != null) {
                    SnackBar snackBar = SnackBar(
                      content: Text(
                        "Halo nama saya $name, dan umur saya $age",
                      ),
                    );
                    scaffoldMessenger.showSnackBar(snackBar);
                  } else {
                    SnackBar snackBar =
                        const SnackBar(content: Text('Invalid data returned'));
                    scaffoldMessenger.showSnackBar(snackBar);
                  }
                } else {
                  SnackBar snackBar = const SnackBar(
                      content: Text('Null or unexpected type returned'));
                  scaffoldMessenger.showSnackBar(snackBar);
                }
              },
              child: const Text("Return Data from Another Screen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/replacementScreen');
              },
              child: const Text("Replace Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
