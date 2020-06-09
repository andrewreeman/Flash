import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CardsPage extends StatefulWidget {
  static const String ROUTE = "/cards";

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  CardListViewModel viewModel;

  bool get _isInHighlightMode => viewModel.areAnyCardsHighlighted();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    viewModel = CardListViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards"),
        backgroundColor: _isInHighlightMode
            ? Theme.of(context).accentColor
            : Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardListItem(
                      frontCardText: viewModel.items[index].frontText,
                      backCardText: viewModel.items[index].backText,
                      isHighlighted: viewModel.items[index].isHighlighted,
                      onPressed: () {
                        if (_isInHighlightMode) {
                          setState(() {
                            viewModel.toggleHighlight(index);
                          });
                        } else {
                          print("Do something else?");
                        }
                      },
                      onLongPressed: () {
                        setState(() {
                          viewModel.toggleHighlight(index);
                        });
                      },
                    ),
                  );
                },
                itemCount: viewModel.count,
              ),
            ),
            GestureDetector(
                onTap: () {
                  print("Bottom safe zone container tapped!");
                  setState(() {
                    viewModel.turnOffAllHighlighted();
                  });
                },
                //behavior: HitTestBehavior.translucent,
                child: Container(
                  height: 80,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 38, top: 16),
                    child: Text(getBottomHelpText(), style: TextStyle(color: Theme.of(context).primaryColor),),
                  ),

                ), // need to actually give this a color so that it has content
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isInHighlightMode
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).accentColor,
        child: Icon(
          _isInHighlightMode ?  Icons.delete_forever : Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          if (_isInHighlightMode) {
            showDialog(
                context: context,
                builder: (context) {
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
                          onPressed: (){
                            print("User said no");
                            Navigator.of(context).pop();
                            setState(() {
                              viewModel.turnOffAllHighlighted();
                            });
                          },
                          child: Text("Cancel"),
                        ),
                        FlatButton(
                          onPressed: (){
                            print("User said yes");
                            Navigator.of(context).pop();
                            setState(() {
                              viewModel.deleteSelectedCards();
                            });
                          },
                          child: Text("Delete", style: TextStyle(color: Theme.of(context).colorScheme.error),),
                        )
                      ],
                      titlePadding: EdgeInsets.zero);
                });
          }
          ;
        },
      ),
    );
  }

  String getBottomHelpText() {
    if(_isInHighlightMode) {
      return "Tap here to unselect everything";
    }
    else {
      return "Tap a card to view and edit";
    }
  }
}

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

class CardListViewModel {
  List<CardListItemViewModel> _items = [
    CardListItemViewModel(
        Card(frontText: "Apa kabar?", backText: "How are you?")),
    CardListItemViewModel(Card(frontText: "Kabar", backText: "News")),
    CardListItemViewModel(Card(frontText: "Banyak", backText: "Many")),
    CardListItemViewModel(
        Card(frontText: "Apa kabar?", backText: "How are you?")),
    CardListItemViewModel(Card(frontText: "Kabar", backText: "News")),
    CardListItemViewModel(Card(frontText: "Banyak", backText: "Many")),
    CardListItemViewModel(
        Card(frontText: "Apa kabar?", backText: "How are you?")),
    CardListItemViewModel(Card(frontText: "Kabar", backText: "News")),
    CardListItemViewModel(Card(frontText: "Banyak", backText: "Many")),
    CardListItemViewModel(
        Card(frontText: "Apa kabar?", backText: "How are you?")),
    CardListItemViewModel(Card(frontText: "Kabar", backText: "News")),
    CardListItemViewModel(Card(frontText: "Banyak", backText: "Many")),
    CardListItemViewModel(
        Card(frontText: "Apa kabar?", backText: "How are you?")),
    CardListItemViewModel(Card(frontText: "Kabar", backText: "News")),
    CardListItemViewModel(Card(frontText: "Banyak", backText: "Many")),
  ];

  int get count => _items.length;
  List<CardListItemViewModel> get items => List.unmodifiable(_items);

  void toggleHighlight(int index) {
    if (index >= count) {
      return;
    }
    _items[index].isHighlighted = !_items[index].isHighlighted;
  }

  bool areAnyCardsHighlighted() {
    return _items.any((element) => element.isHighlighted);
  }

  void turnOffAllHighlighted() {
    _items.forEach((element) {
      element.isHighlighted = false;
    });
  }

  void deleteSelectedCards() {
    _items.removeWhere((element) => element.isHighlighted);
  }
}

class CardListItemViewModel {
  final Card _card;
  bool isHighlighted = false;

  String get frontText => _card.frontText;
  String get backText => _card.backText;

  CardListItemViewModel(this._card);
}

class Card {
  final String frontText;
  final String backText;

  Card({@required this.frontText, @required this.backText});
}
