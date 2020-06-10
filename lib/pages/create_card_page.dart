
import 'package:flash/models/create_card_result.dart';
import 'package:flutter/material.dart';

class CreateCardPage extends StatefulWidget {
  final Function onCancel;
  final ValueSetter<CreateCardResult> onCreate;

  const CreateCardPage({
    this.onCancel,
    this.onCreate,
  });

  @override
  _CreateCardPageState createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  String frontCardText;
  bool frontCardValidationFailed;

  String backCardText;
  bool backCardValidationFailed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    frontCardValidationFailed = false;
    backCardValidationFailed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Text(
            "Create a new card",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
        ),
        Expanded(
          child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Front card text...",
                        errorText: frontCardValidationFailed
                            ? "Enter text for the front of the card"
                            : null),
                    onChanged: (newValue) {
                      frontCardText = newValue;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Back card text...",
                        errorText: backCardValidationFailed
                            ? "Enter text for the back of the card"
                            : null),
                    onChanged: (newValue) {
                      backCardText = newValue;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: widget.onCancel,
                        child: Icon(
                          Icons.close,
                          size: 60.0,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      FlatButton(
                        onPressed: onSubmitPressed,
                        child: Icon(
                          Icons.check,
                          size: 60,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  )
                ],
              )),
        )
      ],
    );
  }

  void onSubmitPressed() {
    if (widget.onCreate == null) {
      return;
    }
    
    frontCardValidationFailed = false;
    backCardValidationFailed = false;
    
    if (frontCardText == null ||
        frontCardText.trim().isEmpty) {
      frontCardValidationFailed = true;
    }
    
    if (backCardText == null ||
        backCardText.trim().isEmpty) {
      backCardValidationFailed = true;
    }
    
    if (frontCardValidationFailed ||
        backCardValidationFailed) {
      setState(() {});
      return;
    }
    
    widget.onCreate(CreateCardResult(
        frontCardText: frontCardText,
        backCardText: backCardText)
    );
    
    return;
  }
}
