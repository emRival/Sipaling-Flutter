import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:headline_news/pages/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String routeName = 'splash_screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, MainPage.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/images.jpg',
            fit: BoxFit.cover,
            height: height * .5,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'HEADLINE NEWS',
            style: GoogleFonts.anton(
                letterSpacing: 2, color: Colors.black, fontSize: 24),
          ),
          const SizedBox(
            height: 25,
          ),
          SpinKitFadingCube(
            color: Colors.amber,
            size: 40,
          )
        ],
      ),
    );
  }
}
