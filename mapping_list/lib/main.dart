import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<Map<String, dynamic>> myList = [
    {
      "name": "Muhammad Rival",
      "age": 22,
      "favColor": [
        "0xFFDC143C",
        "0xFFA9A9A9",
        "0xFF1E90FF",
        "0xFF1E90FF",
        "0xFFFF4500",
        "0xFF008000"
      ]
    },
    {
      "name": "John Doe",
      "age": 30,
      "favColor": ["0xFF1E90FF", "0xFFFF4500", "0xFF008000"]
    },
    {
      "name": "Jane Smith",
      "age": 25,
      "favColor": ["0xFFA52A2A", "0xFF800080", "0xFFFFD700"]
    },
    {
      "name": "Alice Johnson",
      "age": 28,
      "favColor": ["0xFF008080", "0xFFDA70D6", "0xFF2E8B57"]
    },
    {
      "name": "Bob Brown",
      "age": 35,
      "favColor": ["0xFF9370DB", "0xFF00CED1", "0xFF4682B4"]
    },
    {
      "name": "Emily Davis",
      "age": 20,
      "favColor": ["0xFF8B0000", "0xFF00FF00", "0xFF0000FF"]
    },
    {
      "name": "Michael Wilson",
      "age": 26,
      "favColor": ["0xFFFF1493", "0xFF00FA9A", "0xFF20B2AA"]
    },
    {
      "name": "Sophia Martinez",
      "age": 24,
      "favColor": ["0xFF7B68EE", "0xFF7FFF00", "0xFFFFA500"]
    },
    {
      "name": "William Garcia",
      "age": 32,
      "favColor": ["0xFFB22222", "0xFF32CD32", "0xFFDAA520"]
    },
    {
      "name": "Olivia Lopez",
      "age": 29,
      "favColor": ["0xFF3CB371", "0xFFBA55D3", "0xFF4169E1"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Mapping List",
          ),
        ),
        body: ListView(
          children: myList.map((data) {
            List myFavColor = data['favColor'];
            return Card(
              margin: const EdgeInsets.all(10),
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // data user
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nama: ${data['name']}"),
                            Text("Umur: ${data['age']}")
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: myFavColor.map((color) {
                          int colorValue = int.parse(color);
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            padding: EdgeInsets.all(10),
                            color: Color(colorValue),
                            child: Text(
                              color,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    // favColor
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
