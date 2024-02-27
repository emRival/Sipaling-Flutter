import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:quran_app/component/tab_item.dart';
import 'package:quran_app/pages/tabs/doa_tab.dart';
import 'package:quran_app/pages/tabs/dzikr_tab.dart';
import 'package:quran_app/pages/tabs/surah_tab.dart';
import 'package:quran_app/theme.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _namaSurat = 'Yuk Baca Quran';
  late String _nomorSurat = '-';

  late Box<dynamic> _lastReadBox;
  late Stream<BoxEvent> _lastReadStream;

  @override
  void initState() {
    super.initState();
    _lastReadBox = Hive.box('last_read_quran');
    _lastReadStream = _lastReadBox.watch(key: 'last_read');
    _loadLastReadData();
  }

  void _loadLastReadData() {
    final lastReadData = _lastReadBox.get('last_read', defaultValue: null);
    if (lastReadData != null && lastReadData is Map<dynamic, dynamic>) {
      _namaSurat = lastReadData['nama_surah'].toString();
      _nomorSurat = lastReadData['nomor_ayat'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _appBar() => AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/svg/menu_icon.svg'),
        ),
        title: Text(
          'Quran App',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w600, color: primary),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/svg/search_icon.svg'),
          ),
        ],
      );

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          _bottomNavigationBarItem(
              icon: 'assets/svg/quran_icon.svg', label: 'Quran'),
          _bottomNavigationBarItem(
              icon: 'assets/svg/doa_icon.svg', label: 'Doa'),
          _bottomNavigationBarItem(
              icon: 'assets/svg/bookmark_icon.svg', label: 'Bookmark'),
        ],
      );

  BottomNavigationBarItem _bottomNavigationBarItem(
          {required String icon, required String label}) =>
      BottomNavigationBarItem(
          icon: SvgPicture.asset(icon, color: secondary),
          activeIcon: SvgPicture.asset(
            icon,
            color: primary,
          ),
          label: label);

  Widget _body() => DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: _salam(),
            ),
            SliverAppBar(
              pinned: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              shape: Border(
                bottom: BorderSide(
                  width: 3,
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: TabBar(
                  labelColor: primary,
                  indicatorColor: primary,
                  indicatorWeight: 3,
                  tabs: [
                    itemTab(label: "Surah"),
                    itemTab(label: "Dzikr"),
                    itemTab(label: "Doa"),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [TabSurah(), TabDzikr(), TabDoa()],
          ),
        ),
      );

  Widget _salam() => StreamBuilder<BoxEvent>(
        stream: _lastReadStream,
        builder: (context, snapshot) {
          _loadLastReadData(); // Reload data when box changes
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Assalamualikum',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: secondary),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Rival',
                  style: GoogleFonts.poppins(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double containerWidth =
                            MediaQuery.of(context).size.width;
                        return Container(
                          height: 150,
                          width: containerWidth,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xffdf98fa), Color(0xff9055ff)],
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: SvgPicture.asset(
                                  'assets/svg/quran_banner.svg',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset('assets/svg/book.svg'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Last Read",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      _namaSurat,
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Ayat No: $_nomorSurat",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
}
