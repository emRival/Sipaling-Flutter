import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:quran_app/component/tab_item.dart';
import 'package:quran_app/pages/bookmark/bookmark_page.dart';
import 'package:quran_app/pages/quran/quran_page.dart';
import 'package:quran_app/pages/quran/tabs/doa_tab.dart';
import 'package:quran_app/pages/quran/tabs/dzikr_tab.dart';
import 'package:quran_app/pages/quran/tabs/surah_tab.dart';
import 'package:quran_app/theme.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        // Return Quran page
        return QuranPage();
      case 1:
        // Return Doa page
        return Center(child: Text('Doa Page'));
      case 2:
        // Return Bookmark page
        return BookmarkPage();
      default:
        return Center(child: Text('Unknown Page'));
    }
  }

  CurvedNavigationBar _bottomNavigationBar() => CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.transparent,
        color: primary.withOpacity(0.7),
        animationCurve: Curves.easeInOutSine,
        animationDuration: const Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          SvgPicture.asset(
            'assets/svg/quran_icon.svg',
            color: Colors.white,
            height: 25,
          ),
          SvgPicture.asset(
            'assets/svg/doa_icon.svg',
            color: Colors.white,
            height: 25,
          ),
          SvgPicture.asset(
            'assets/svg/bookmark_icon.svg',
            color: Colors.white,
            height: 25,
          ),
        ],
      );
}
