import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scan file app',
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme().apply(
          displayColor: kTextColor
        ),
        appBarTheme: AppBarTheme(
          textTheme: GoogleFonts.dmSansTextTheme().apply(
            displayColor: kTextColor
          ),
          elevation: 0,
          brightness: Brightness.light,
          color: Colors.transparent
        ),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}