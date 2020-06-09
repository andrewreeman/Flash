import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GamePage extends StatelessWidget {
  static const String ROUTE = "/game";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game"),),
      body: Text("Game page"),
    );
  }
}
