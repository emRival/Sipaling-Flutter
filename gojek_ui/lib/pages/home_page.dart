import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gojek_ui/components/Gopay.dart';
import 'package:gojek_ui/components/Header.dart';
import 'package:gojek_ui/components/News.dart';
import 'package:gojek_ui/components/akses_cepat.dart';
import 'package:gojek_ui/components/go_club.dart';
import 'package:gojek_ui/components/menu_icons.dart';
import 'package:gojek_ui/datas/icons.dart';
import 'package:gojek_ui/datas/news.dart';
import 'package:gojek_ui/theme.dart';

import '../components/Search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: green2,
        //115 - 44 (ukuran system toolbar)
        toolbarHeight: 71,
        title: const Header(),
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Search(),
            Gopay(),
            MenuIcons(),
            GoClub(),
            AksesCepat(),
            News()
          ],
        ),
      ),
    );
  }
}
