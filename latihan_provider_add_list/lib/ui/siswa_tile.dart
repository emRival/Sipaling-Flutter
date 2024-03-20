import 'package:flutter/material.dart';

class SiswaTile extends StatelessWidget {
  String siswaName;
  bool isDone;
  final Function() onClick;
  SiswaTile(
      {super.key,
      required this.siswaName,
      required this.isDone,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(siswaName),
      trailing: isDone
          ? const Icon(Icons.done)
          : ElevatedButton(
              onPressed: onClick,
              child: const Text("Done"),
            ),
    );
  }
}
