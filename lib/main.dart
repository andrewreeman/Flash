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
        primaryColor: Colors.purple,
        accentColor: Colors.greenAccent
      ),
      routes: {
        "/" : (context) => HomePage(),
        "/game" : (context) => GamePage(),
        "/cards" : (context) => CardsPage()

      },
    );
  }
}
