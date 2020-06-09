import 'package:flutter/material.dart';

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
              NavigationButton(),
              NavigationButton(),
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: RaisedButton(
        child: Ink(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Card list", style: TextStyle(color: Colors.purple, fontSize: 24),),
              Icon(Icons.arrow_forward, color: Colors.black)
            ],
          ),
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[ Colors.white, Colors.grey.shade300, ]),
            borderRadius:BorderRadius.circular(5.0)
//          border: Border(left: BorderSide(color: Colors.purple, width: 8))

          ),
        ),
        elevation: 8.0,
        padding: EdgeInsets.zero,
        onPressed: onButtonPressed,
      ),
    );
  }

  void onButtonPressed() {

  }
}


/*
 FlatButton(
      onPressed: onButtonPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.all(64),
      child: Text("Card list", style: TextStyle(color: Colors.black, fontSize: 24),),
    );
 */

/*
Container(
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Padding(
          padding: const EdgeInsets.all(64.0),
          child: Text("Card list", style: TextStyle(color: Colors.white),),
        ),
      ),
 */