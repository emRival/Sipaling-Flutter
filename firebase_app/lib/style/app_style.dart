import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgColor = Color(0xFFe2e2ff);
  static Color mainColor = Color(0xff000633);
  static Color accentColor = Color(0xFF0065FF);

  static List<Color> cardsColors = [
    Colors.white,
    Colors.red.shade200,
    Colors.pink.shade200,
    Colors.purple.shade200,
    Colors.deepOrange.shade200,
    Colors.green.shade200,
    Colors.yellow.shade200,
    Colors.blue.shade200,
    Colors.indigo.shade200,
    Colors.teal.shade200,
  ];

  static TextStyle mainTitle = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle mainContent = GoogleFonts.roboto(
    fontSize: 16,
  );
  static TextStyle dateTitle = GoogleFonts.roboto(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
}
