import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final Function onPositiveButtonTapped;
  final Function onNegativeButtonTapped;

  const DeleteDialog(
      {this.onPositiveButtonTapped, this.onNegativeButtonTapped});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Container(
          color: Theme.of(context).colorScheme.error,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        content: Text(
          'Delete selected cards?',
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: onPositiveButtonTapped,
            child: Text("Cancel"),
          ),
          FlatButton(
            onPressed: onNegativeButtonTapped,
            child: Text(
              "Delete",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          )
        ],
        titlePadding: EdgeInsets.zero);
  }
}