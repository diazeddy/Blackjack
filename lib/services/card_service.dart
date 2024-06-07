import 'package:playing_cards/playing_cards.dart';

abstract class CardService {
  void newDeck();
  void shuffleCards(List<PlayingCard> deck);
  PlayingCard drawCard();
  List<PlayingCard> drawCards(int amount);
  void discardCard(PlayingCard card);
  void discardCards(List<PlayingCard> cards);
}
