import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tugas_farrell/theme.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "home_screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _botomNavigationBar(),
    );
  }
}

AppBar _appBar() => AppBar(
      backgroundColor: background,
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset("assets/svg/menu_icon.svg"),
      ),
      title: Text(
        "Quran App",
        style: GoogleFonts.Poppins(
          fontSize: 18,fontWeight: FontWeight.w600, color: primary,)
        ),
        actions: [
          IconButton(onPressed: () {}, icon: SvgPicture.asset("assets/svg/search_icon.svg"))
        ],
    );
