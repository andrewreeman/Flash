import 'package:flutter/material.dart';

import 'cards_page.dart';
import 'game_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flash")),
      body: Container(
        color: Colors.grey.shade200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NavigationButton(text: "Cards", onPressed: (){
                Navigator.pushNamed(context, CardsPage.ROUTE);
              }),
              NavigationButton(text: "Play", onPressed: (){
                Navigator.pushNamed(context, GamePage.ROUTE);
              }),
          ],),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          print("Fab pressed");
        },
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const NavigationButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: RaisedButton(
        child: Ink(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(text ?? "", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),),
              Icon(Icons.arrow_forward, color: Colors.grey.shade600)
            ],
          ),
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[ Colors.white, Colors.grey.shade200, ]),
            borderRadius: BorderRadius.circular(5.0)
            //border: Border(left: BorderSide(color: Colors.purple, width: 8))

          ),
        ),
        elevation: 4,
        disabledColor: Colors.transparent,
        padding: EdgeInsets.zero,
        onPressed: (){
          if(onPressed != null) {
            onPressed();
          }
        },
      ),
    );
  }
}

