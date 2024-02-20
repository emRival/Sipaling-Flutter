import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:headline_news/models/news_channel_headlines_model.dart';
import 'package:headline_news/pages/webview.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  static String routeName = 'detail_page';
  final Articles news;
  const DetailPage({super.key, required this.news});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.parse(widget.news.publishedAt.toString());
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("MMMM dd, yyyy");

    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              height: 450,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.news.urlToImage.toString(),
                placeholder: (context, url) => Container(
                  child: const SpinKitCircle(color: Colors.amber),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              // height: 100,
              margin: const EdgeInsets.only(top: 360),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView(
                  children: [
                    Text(
                      widget.news.title.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.news.source!.name.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Colors.red),
                            maxLines: 2,
                          ),
                        ),
                        Text(
                          format.format(dateTime),
                          style: GoogleFonts.poppins(
                              fontSize: 17, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Text(
                      widget.news.content.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, WebView.routeName,
                            arguments: widget.news.url.toString());
                      },
                      icon: Icon(Icons.open_in_browser_sharp),
                      label: Text('Baca Selengkapnya'),
                      style: ButtonStyle(
                        alignment: Alignment.centerLeft,
                        iconColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
