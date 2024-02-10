import 'package:flutter/material.dart';
import 'dart:math';

class SecoundPage extends StatefulWidget {
  const SecoundPage({super.key});

  @override
  State<SecoundPage> createState() => _SecoundPageState();
}

class _SecoundPageState extends State<SecoundPage> {
  int _number = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Press Button"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: getMainAxisAlignmentColumn(),
          children: [
            Row(
              mainAxisAlignment: getMainAxisAlignmentRow(),
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _number = Random().nextInt(10);
                    });
                    print(_number);
                  },
                  child: Text("Press"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  MainAxisAlignment getMainAxisAlignmentColumn() {
    switch (_number) {
      case 0:
        return MainAxisAlignment.start;
      case 1:
        return MainAxisAlignment.center;
      case 2:
        return MainAxisAlignment.end;
      case 3:
        return MainAxisAlignment.start;
      case 4:
        return MainAxisAlignment.center;
      case 5:
        return MainAxisAlignment.end;
      case 6:
        return MainAxisAlignment.center;
      case 7:
        return MainAxisAlignment.center;
      case 8:
        return MainAxisAlignment.start;
      case 9:
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.start;
    }
  }

  MainAxisAlignment getMainAxisAlignmentRow() {
    switch (_number) {
      case 0:
        return MainAxisAlignment.start;
      case 1:
        return MainAxisAlignment.center;
      case 2:
        return MainAxisAlignment.end;
      case 3:
        return MainAxisAlignment.end;
      case 4:
        return MainAxisAlignment.center;
      case 5:
        return MainAxisAlignment.start;
      case 6:
        return MainAxisAlignment.start;
      case 7:
        return MainAxisAlignment.end;
      case 8:
        return MainAxisAlignment.center;
      case 9:
        return MainAxisAlignment.center;
      default:
        return MainAxisAlignment.start;
    }
  }
}
