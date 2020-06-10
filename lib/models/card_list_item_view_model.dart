import 'flash_card.dart';

class CardListItemViewModel {
  final FlashCard _card;
  bool isHighlighted = false;

  String get frontText => _card.frontText;
  String get backText => _card.backText;

  CardListItemViewModel(this._card);
}
