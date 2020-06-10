
import 'package:flash/models/card_list_view_model.dart';
import 'package:flutter/material.dart';

import 'card_list_item.dart';

class CardList extends StatelessWidget {
  final CardListViewModel viewModel;
  final ScrollController scrollController;
  final Function(int) onCardItemPressed;
  final Function(int) onCardItemLongPressed;

  const CardList(this.viewModel,
      {this.scrollController,
        this.onCardItemPressed,
        this.onCardItemLongPressed});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        controller: scrollController,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CardListItem(
              frontCardText: viewModel.items[index].frontText,
              backCardText: viewModel.items[index].backText,
              isHighlighted: viewModel.items[index].isHighlighted,
              onPressed: () {
                if (onCardItemPressed != null) {
                  onCardItemPressed(index);
                }
              },
              onLongPressed: () {
                if (onCardItemLongPressed != null) {
                  onCardItemLongPressed(index);
                }
              },
            ),
          );
        },
        itemCount: viewModel.count,
      ),
    );
  }
}
