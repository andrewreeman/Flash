import 'package:flash/pages/cards_page.dart';
import 'package:flash/pages/game_page.dart';
import 'package:flash/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FlashApp());
}

class FlashApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
        primaryColorDark: Colors.teal.shade800,
        accentColor: Colors.orangeAccent,
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline1: TextStyle(color: Colors.white)
          )
        )
//        appBarTheme: Theme.of(context).appBarTheme.copyWith(te)

      ),
      routes: {
        "/" : (context) => HomePage(),
        GamePage.ROUTE : (context) => GamePage(),
        CardsPage.ROUTE : (context) => CardsPage()

      },
    );
  }
}
