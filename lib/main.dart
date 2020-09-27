import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:virus_total_api/constants.dart';
import 'package:virus_total_api/fluro_router.dart';
import 'viewmodel/blocs/bloc_observer.dart';
import 'models/nav_item.dart';

void main() {
  Bloc.observer= CommonBlocObserver();
  FluroRouter().setRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavItems(),
      child: MaterialApp(
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
        initialRoute: '/',
        onGenerateRoute: FluroRouter.router.generator,
        //home: CommentScreen(),
      ),
    );
  }
}