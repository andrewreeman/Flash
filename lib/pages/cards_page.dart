import 'dart:async';
import 'package:flash/models/card_list_view_model.dart';
import 'package:flash/models/create_card_result.dart';
import 'package:flash/widgets/card_list.dart';
import 'package:flash/widgets/delete_card_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'create_card_page.dart';

class CardsPage extends StatefulWidget {
  static const String ROUTE = "/cards";

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  CardListViewModel viewModel;
  ScrollController scrollController;

  bool get _isInHighlightMode => viewModel.areAnyCardsHighlighted();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    viewModel = CardListViewModel();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: body(),
      ),
      floatingActionButton: primaryButton(context),
    );
  }

  // Widget creation methods
  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text("Cards"),
      backgroundColor: _isInHighlightMode
          ? Theme.of(context).accentColor
          : Theme.of(context).primaryColor,
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[cardList(), instructionText()],
    );
  }

  Widget cardList() {
    return CardList(
      viewModel,
      scrollController: scrollController,
      onCardItemPressed: onCardItemPressed,
      onCardItemLongPressed: onCardItemLongPressed,
    );
  }

  Widget instructionText() {
    return _InstructionText(
      _getBottomHelpText(),
      onTapped: () {
        setState(() {
          viewModel.turnOffAllHighlighted();
        });
      },
    );
  }

  _PrimaryButton primaryButton(BuildContext context) {
    return _PrimaryButton(
        isInHighlightMode: _isInHighlightMode,
        onPressed: () {
          if (_isInHighlightMode) {
            _askDeleteSelected(context);
          } else {
            _showAddCard(context);
          }
        });
  }

  Widget createCardPage(BuildContext context) {
    return CreateCardPage(
        onCancel: () => Navigator.pop(context),
        onCreate: (result) => onCreateCard(context, result));
  }

  DeleteDialog deleteDialog(BuildContext context) {
    return DeleteDialog(
      onPositiveButtonTapped: () => onDeleteCancelled(context),
      onNegativeButtonTapped: () => onDeleteAllSelected(context),
    );
  }

  // callbacks
  void onCardItemPressed(int index) {
    if (_isInHighlightMode) {
      toggleHighlight(index);
    } else {
      print("Do something else?");
    }
  }

  void onCardItemLongPressed(int index) {
    toggleHighlight(index);
  }

  void onDeleteAllSelected(BuildContext context) {
    Navigator.of(context).pop();
    setState(() {
      viewModel.deleteSelectedCards();
    });
  }

  void onDeleteCancelled(BuildContext context) {
    Navigator.of(context).pop();
    setState(() {
      viewModel.turnOffAllHighlighted();
    });
  }


  void onCreateCard(BuildContext context, CreateCardResult createCardResult) {
    Navigator.pop(context);
    createNewCard(createCardResult);
    scrollToBottom();
  }

  void _askDeleteSelected(BuildContext context) {
    showDialog(context: context, builder: deleteDialog);
  }

  void _showAddCard(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: createCardPage);
  }

  void createNewCard(CreateCardResult createCardResult) {
    setState(() {
      viewModel.createNewCard(
          createCardResult.frontCardText, createCardResult.backCardText);
    });
  }

  void toggleHighlight(int index) {
    setState(() {
      viewModel.toggleHighlight(index);
    });
  }

  String _getBottomHelpText() {
    if (_isInHighlightMode) {
      return "Tap here to unselect everything";
    } else {
      return "Tap a card to view and edit";
    }
  }

  void scrollToBottom() {
    Timer(Duration(milliseconds: 200), () {
      setState(() {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(seconds: 1), curve: Curves.ease);
      });
    });
  }
}

// Private widgets
class _InstructionText extends StatelessWidget {
  final Function onTapped;
  final String text;

  const _InstructionText(this.text, {this.onTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        height: 80,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 38, top: 16),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ), // need to actually give this a color so that it has content
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final bool isInHighlightMode;
  final Function onPressed;

  const _PrimaryButton({this.isInHighlightMode, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: isInHighlightMode
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).accentColor,
      child: Icon(
        isInHighlightMode ? Icons.delete_forever : Icons.add,
        color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
