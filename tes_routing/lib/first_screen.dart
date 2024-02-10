import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int myNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Routing Test"),
      ),
      body: Column(
        mainAxisAlignment: myNumber == 0
            ? MainAxisAlignment.start
            : myNumber == 1
                ? MainAxisAlignment.center
                : MainAxisAlignment.end,
        crossAxisAlignment: myNumber == 0
            ? CrossAxisAlignment.start
            : myNumber == 1
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: myNumber == 0
                ? MainAxisAlignment.start
                : myNumber == 1
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.end,
            crossAxisAlignment: myNumber == 0
                ? CrossAxisAlignment.start
                : myNumber == 1
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (myNumber == 2) {
                      myNumber = 0;
                    } else {
                      myNumber += 1;
                    }
                  });
                },
                child: const Text("Press"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
