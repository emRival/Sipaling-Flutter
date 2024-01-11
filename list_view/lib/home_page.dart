import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // i want to make botton tab bar
    return ListView(
      children: const [
        ListTile(
          leading: CircleAvatar(),
          title: Text("Asep Jonatan"),
          subtitle: Text("Flutter Developer"),
          trailing: Text("10:00"),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(),
          title: Text("Asep Jonatan"),
          subtitle: Text("Flutter Developer"),
          trailing: Text("10:00"),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(),
          title: Text("Asep Jonatan"),
          subtitle: Text("Flutter Developer"),
          trailing: Text("10:00"),
        ),
        Divider(),
        ListTile(
          leading: CircleAvatar(),
          title: Text("Asep Jonatan"),
          subtitle: Text("Flutter Developer"),
          trailing: Text("10:00"),
        ),
        Divider()
      ],
    );
  }
}
