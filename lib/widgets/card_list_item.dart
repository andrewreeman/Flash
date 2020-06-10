
import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget {
  final String frontCardText;
  final String backCardText;
  final Function onPressed;
  final Function onLongPressed;
  final bool isHighlighted;

  const CardListItem(
      {this.frontCardText,
        this.backCardText,
        this.isHighlighted,
        this.onPressed,
        this.onLongPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: FlatButton(
        child: Ink(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Text(
                  frontCardText ?? "",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: 10,
                ),
              ),
              Flexible(
                flex: 5,
                child: Text(
                  backCardText ?? "",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark, fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              )
            ],
          ),
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.white,
                Colors.grey.shade200,
              ]),
              border: Border(
                  left: BorderSide(
                      color: isHighlighted
                          ? Theme.of(context).accentColor
                          : Theme.of(context).primaryColor,
                      width: 8))),
        ),
        disabledColor: Colors.transparent,
        padding: EdgeInsets.zero,
        onPressed: () {
          print("List item pressed");
          if (onPressed != null) {
            onPressed();
          }
        },
        onLongPress: () {
          if (onLongPressed != null) {
            onLongPressed();
          }
        },
      ),
    );
  }
}
