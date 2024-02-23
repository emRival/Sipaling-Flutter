import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:headline_news/models/news_channel_headlines_model.dart';
import 'package:headline_news/pages/categorys_page.dart';
import 'package:headline_news/pages/detail_page.dart';
import 'package:headline_news/view_model/news_view_model.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  static String routeName = 'main_page';
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat("MMMM dd, yyyy");

  String name = 'cnn';

  @override
  void initState() {
    super.initState();
    // Memanggil fungsi untuk mendapatkan nama acak saat pertama kali halaman dimuat
    generateRandomName();
  }

  void generateRandomName() {
    // Daftar nama yang mungkin
    List<String> possibleNames = [
      'bbc-news',
      'ary-news',
      'reuters',
      'cnn',
    ];

    // Mendapatkan index acak dari daftar nama
    int randomIndex = Random().nextInt(possibleNames.length);

    // Mengatur nilai name menjadi nama yang dipilih secara acak
    setState(() {
      name = possibleNames[randomIndex];
      print(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, CategorysPage.routeName);
          },
          icon: Image.asset(
            'assets/images/category_icon.png',
            width: 20,
            height: 20,
          ),
        ),
        title: Text(
          "News APP",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigasi ke halaman pencarian ketika tombol pencarian ditekan
              // Navigator.pushNamed(context, SearchPage.routeName);
            },
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlineModel>(
              future: newsViewModel.fetchNewChannelHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Color.fromARGB(255, 133, 117, 71),
                      size: 50,
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());

                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, DetailPage.routeName,
                              arguments: snapshot.data!.articles![index]);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * 0.5,
                              width: width * .9,
                              padding: EdgeInsets.symmetric(
                                  horizontal: height * .02),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: Spinkit2,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                height: height * .15,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: width * 0.7,
                                      child: Text(
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: name == 'ary-news'
                                            ? TextAlign.end
                                            : TextAlign.start,
                                      ),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: width * 0.7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red),
                                          ),
                                          Text(
                                            format.format(dateTime),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          FutureBuilder<NewsChannelHeadlineModel>(
            future: newsViewModel.fetchNewsCategoryApi('general'),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.data == null) {
                return Center(
                  child: SpinKitCircle(
                    color: Colors.amber,
                    size: 50,
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    DateTime dateTime = DateTime.parse(
                      snapshot.data!.articles![index].publishedAt.toString(),
                    );

                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, DetailPage.routeName,
                            arguments: snapshot.data!.articles![index]);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                height: height * .18,
                                width: width * .3,
                                placeholder: (context, url) => Container(
                                  child: Spinkit2,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: height * .18,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot
                                          .data!.articles![index].description
                                          .toString(),
                                      maxLines: 4,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            snapshot.data!.articles![index]
                                                .source!.name
                                                .toString(),
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                                color: Colors.red,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        Text(
                                          format.format(dateTime),
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

const Spinkit2 = SpinKitCircle(
  color: Colors.amber,
  size: 40,
);
