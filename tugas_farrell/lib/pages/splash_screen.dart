import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tugas_farrell/theme.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "splash_screen";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(padding: EdgeInsets.all(8.0),
      child: Center(child: Column(
        children: [
          Text(
            "Quranku",
            style: GoogleFonts.Poppins(
              fontSize: 28,
              color: primary,
              fontWeight: FontWeight.bold,),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Learn Quran And \nRecite one everyday",
            style: GoogleFonts.Poppins(
              fontSize: 18,
              color: secondary,
            )),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 450,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SvgPicture.asset("assets/svg/splash.svg"),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);  
                },
                child: Text(
                  "Get Started",
                  style: GoogleFonts.Poppins(
                    fontWeight: FontWeight.w600, fontSize: 18
                  ),
                ),
                ),),
            )
          ],
        )
        ],
      )),),
    )
  }
}