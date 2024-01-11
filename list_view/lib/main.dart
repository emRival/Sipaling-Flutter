import 'package:flutter/material.dart';
import 'package:simple_app/account_page.dart';
import 'package:simple_app/home_page.dart';
import 'package:simple_app/setting_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Tab> myTabs = [
    Tab(
      icon: Icon(Icons.home),
      text: "Home",
    ),
    Tab(
      icon: Icon(Icons.settings),
      text: "Settings",
    ),
    Tab(
      icon: Icon(Icons.account_circle),
      text: "Account",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: const Center(child: Text("Main Page")),
            bottom: TabBar(
                indicatorColor: Colors.blueGrey,
                indicatorWeight: 5,
                unselectedLabelColor: Colors.blueGrey,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: myTabs),
          ),
          body: TabBarView(
            children: [HomePage(), SettingPage(), AccountPage()],
          ),
        ),
      ),
    );
  }
}
