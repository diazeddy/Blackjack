import 'package:playing_cards/playing_cards.dart';

const double baseMoney = 5000;
const int betStep = 100;
const int minBet = 100;
const int maxBet = 500;
const double winMultiplicator = 1.5;

class Player {
  List<PlayingCard> cards;
  int win = 0;
  int lose = 0;

  double money = baseMoney;

  int bet = minBet;

  Player(this.cards);

  int increaseBet() {
    final newBet = bet + betStep;
    if (newBet <= money && newBet <= maxBet) {
      bet = newBet;
    }
    return bet;
  }

  int decreaseBet() {
    final newBet = bet - betStep;
    if (newBet >= minBet) {
      bet = newBet;
    }
    return bet;
  }

  void winNatural() {
    money += bet * winMultiplicator;
  }

  void winBet() {
    money += bet;
  }

  void loseBet() {
    final newMoney = money - bet;
    if (newMoney <= 0) {
      money = baseMoney;
    } else {
      money = newMoney;
    }
  }
}
