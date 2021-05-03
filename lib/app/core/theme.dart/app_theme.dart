import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static getTheme() {
    final ThemeData base = ThemeData.light();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: base.scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    return base.copyWith(
      primaryColor: Colors.blue,
      iconTheme: IconThemeData(color: Colors.black54),
      cardTheme: base.cardTheme.copyWith(
        elevation: 0.1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5)),
      ),
      textTheme: GoogleFonts.latoTextTheme(base.textTheme).copyWith(
        headline6:
            GoogleFonts.montserrat().copyWith(fontWeight: FontWeight.w500),
      ),
      appBarTheme: base.appBarTheme.copyWith(
        color: base.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
    );
  }
}
