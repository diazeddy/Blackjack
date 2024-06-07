import 'package:playing_cards/playing_cards.dart';

import '/models/player_model.dart';
import 'card_service_imp.dart';
import 'card_service.dart';
import 'game_service.dart';

const int highestScoreValue = 21;
const int dealerMinScore = 17;

class GameServiceImp extends GameService {
  late Player player;
  late Player dealer;
  GameState gameState = GameState.equal;

  GameServiceImp() {
    dealer = Player(_cardService.drawCards(2));
    player = Player(_cardService.drawCards(2));
  }

  final CardService _cardService = CardServiceImp();

  @override
  void startNewGame() {
    player.cards = _cardService.drawCards(2);
    dealer.cards = _cardService.drawCards(2);
    _cardService.newDeck();
    gameState = GameState.playerActive;
  }

  @override
  PlayingCard drawCard() {
    final drwanCard = _cardService.drawCard();
    player.cards.add(drwanCard);
    if (getScore(player) >= highestScoreValue) {
      endTurn();
    }
    return drwanCard;
  }

  @override
  void endTurn() {
    // Dealer turn
    int dealerScore = getScore(dealer);
    while (dealerScore < dealerMinScore) {
      dealer.cards.add(_cardService.drawCard());
      dealerScore = getScore(dealer);
    }

    // Get burnt players
    final playerScore = getScore(player);
    final bool burntDealer = (dealerScore > highestScoreValue);
    final bool burntPlayer = (playerScore > highestScoreValue);

    // Find game result
    if (burntDealer && burntPlayer) {
      gameState = GameState.equal;
    } else if (dealerScore == playerScore) {
      gameState = GameState.equal;
    } else if (playerScore == highestScoreValue) {
      playerWonNatural();
    } else if (burntDealer && playerScore < highestScoreValue) {
      playerWon();
    } else if (burntPlayer && dealerScore <= highestScoreValue) {
      dealerWon();
    } else if (dealerScore < playerScore) {
      playerWon();
    } else if (dealerScore > playerScore) {
      dealerWon();
    }
  }

  void playerWonNatural() {
    gameState = GameState.playerWon;
    player.win += 1;
    dealer.lose += 1;
    player.winNatural();
  }

  void playerWon() {
    gameState = GameState.playerWon;
    player.win += 1;
    dealer.lose += 1;
    player.winBet();
  }

  void dealerWon() {
    gameState = GameState.dealerWon;
    dealer.win += 1;
    player.lose += 1;
    player.loseBet();
  }

  @override
  Player getPlayer() {
    return player;
  }

  @override
  Player getDealer() {
    return dealer;
  }

  @override
  int getScore(Player player) {
    return mapCardValueRules(player.cards);
  }

  @override
  GameState getGameState() {
    return gameState;
  }

  @override
  String getWinner() {
    if (GameState.dealerWon == gameState) {
      return "Dealer";
    }
    if (GameState.playerWon == gameState) {
      return "You";
    }
    return "Nobody";
  }
}

/// Map blackjack rules for card values to the PlayingCard enum
int mapCardValueRules(List<PlayingCard> cards) {
  List<PlayingCard> standardCards = cards
      .where((card) => (0 <= card.value.index && card.value.index <= 11))
      .toList();

  final sumStandardCards = getSumOfStandardCards(standardCards);

  int acesAmount = cards.length - standardCards.length;
  if (acesAmount == 0) {
    return sumStandardCards;
  }

  // Special case: Ace could be value 1 or 11
  final pointsLeft = highestScoreValue - sumStandardCards;
  final oneAceIsEleven = 11 + (acesAmount - 1);

  // One Ace with value 11 fits
  if (pointsLeft >= oneAceIsEleven) {
    return sumStandardCards + oneAceIsEleven;
  }

  return sumStandardCards + acesAmount;
}

int getSumOfStandardCards(List<PlayingCard> standardCards) {
  return standardCards.fold<int>(
      0, (sum, card) => sum + mapStandardCardValue(card.value.index));
}

int mapStandardCardValue(int cardEnumIdex) {
  const gapBetweenIndexAndValue = 2;

  // Card value 2-10 -> index between 0 and 8
  if (0 <= cardEnumIdex && cardEnumIdex <= 8) {
    return cardEnumIdex + gapBetweenIndexAndValue;
  }

  // Card is jack, queen, king -> index between9 and 11
  if (9 <= cardEnumIdex && cardEnumIdex <= 11) {
    return 10;
  }

  return 0;
}
