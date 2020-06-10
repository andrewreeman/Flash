import 'card_list_item_view_model.dart';
import 'flash_card.dart';

class CardListViewModel {
  List<CardListItemViewModel> _items = [
    CardListItemViewModel(
        FlashCard(frontText: "Apa kabar?", backText: "How are you?")),
    CardListItemViewModel(FlashCard(frontText: "Kabar", backText: "News")),
    CardListItemViewModel(FlashCard(frontText: "Banyak", backText: "Many")),
    CardListItemViewModel(
        FlashCard(frontText: "Apa kabar?", backText: "How are you?")),
    CardListItemViewModel(FlashCard(frontText: "Kabar", backText: "News")),
    CardListItemViewModel(FlashCard(frontText: "Banyak", backText: "Many")),
    CardListItemViewModel(
        FlashCard(frontText: "Apa kabar?", backText: "How are you?")),
    CardListItemViewModel(FlashCard(frontText: "Kabar", backText: "News")),
    CardListItemViewModel(FlashCard(frontText: "Banyak", backText: "Many")),
    CardListItemViewModel(
        FlashCard(frontText: "Apa kabar?", backText: "How are you?")),
    CardListItemViewModel(FlashCard(frontText: "Kabar", backText: "News")),
    CardListItemViewModel(FlashCard(frontText: "Banyak", backText: "Many")),
    CardListItemViewModel(
        FlashCard(frontText: "Apa kabar?", backText: "How are you?")),
    CardListItemViewModel(FlashCard(frontText: "Kabar", backText: "News")),
    CardListItemViewModel(FlashCard(frontText: "Banyak", backText: "Many")),
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

  void createNewCard(String frontText, String backText) {
    _items.add(
        CardListItemViewModel(FlashCard(frontText: frontText, backText: backText))
    );
  }
}