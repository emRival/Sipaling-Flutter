import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:headline_news/models/news_channel_headlines_model.dart';
import 'package:headline_news/pages/detail_page.dart';
import 'package:headline_news/view_model/news_view_model.dart';
import 'package:intl/intl.dart';

class CategorysPage extends StatefulWidget {
  static String routeName = 'category_page';
  const CategorysPage({super.key});

  @override
  State<CategorysPage> createState() => _CategorysPageState();
}

class _CategorysPageState extends State<CategorysPage> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMMM dd, yyyy");

  List<String> myCategoryList = [
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  String categoryName = 'general';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$categoryName News'.toUpperCase(),
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: myCategoryList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      categoryName = myCategoryList[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: categoryName == myCategoryList[index]
                              ? Colors.amber
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.amber),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              myCategoryList[index].toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            FutureBuilder<NewsChannelHeadlineModel>(
              future: newsViewModel.fetchNewsCategoryApi(categoryName),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.amber,
                      size: 50,
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(
                          snapshot.data!.articles![index].publishedAt
                              .toString(),
                        );

                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, DetailPage.routeName,
                                arguments: snapshot.data!.articles![index]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
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
                                ))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

const Spinkit2 = SpinKitCircle(
  color: Colors.amber,
  size: 50,
);
