import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final List<Color> myColor = [Colors.red, Colors.green, Colors.blue];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: myColor.length,
        itemBuilder: (context, index) {
          return Container(
            height: 400,
            color: myColor[index],
          );
        });
  }
}
