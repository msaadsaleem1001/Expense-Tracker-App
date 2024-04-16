
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {

  static TextStyle titleStyle({double fontSize = 18, Color color = Colors.white}){
    return GoogleFonts.dosis(
      color: color,
      fontWeight: FontWeight.w800,
      fontSize: fontSize,
      letterSpacing: 2,
    );
  }

  static TextStyle subTitleStyle({double fontSize = 14, Color color = Colors.white}){
    return GoogleFonts.dosis(
      color: color,
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      letterSpacing: 1.5,
    );
  }

  static TextStyle bodyStyle({double fontSize = 12, Color color = Colors.white}){
    return GoogleFonts.dosis(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w200,
        letterSpacing: 1
    );
  }

}
