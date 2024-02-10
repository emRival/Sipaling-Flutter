import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Menu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ind');
              },
              child: Text("Increment dan Decrement"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pbtn');
              },
              child: Text("Press Button"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mwd',
                    arguments: "Hallo ini dari halaman utama");
              },
              child: Text("Move With Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(context, '/rds');
                final message = result ?? "Data Kosong";

                if (message is Map) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "halo nama saya ${message['name']} umur saya ${message['age']} tahun dan saya tinggal di ${message['address']}"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message.toString()),
                    ),
                  );
                }
              },
              child: Text("Move With Data"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/rp');
              },
              child: Text("Replace Page"),
            ),
          ],
        ),
      ),
    );
  }
}
