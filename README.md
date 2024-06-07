# Blackjack

Build a program that plays the card game Blackjack against the computer dealer.
It's a single-player game and implements the correct winning condition, game-playing rule, and betting functionality.

![Blackjack](https://github.com/diazeddy/Blackjack/assets/158232252/2d7b4a96-2625-4da3-825f-83b6423c708c)

## Challenges
- The Ace can have 2 values 1 and 11 so should determine the value correctly.
- Should check the current game status and determine the winning or losing condition carefully.

## Environment
- Flutlab.io online editor
- Flutter 3.16
- Web app

## Steps to run the project
- Clone the project.
- Install dependencies
  ```
  flutter pub get
  ```
- Run app
  ```
  flutter run
  ```

## How to play
- Start the game by tapping the "New Game" button.
- You can also change your bet amount. The minimum is 100 and maximum is 500.
- At first, 2 cards are shown on your end, 1 card is shown and 1 card is hidden on the dealer's end.
- You can "hit" by clicking the cards or "stand" by clicking the "Finish" button.
- Then the dealer will play according to the rules of the game.
- If your card's value and dealer's value are the same, there will be no winner.
- If your card's value is 21, then you are natural and the dealer will pay 1.5 times your bet.
- If your card's value is higher than the dealer's value (not exceeding 21) then the dealer will pay the same as your bet.
- If your card's value is not exceeding 21 and the dealer's value is greater than 21, then the dealer will pay the same as your bet.
- If you exceed 21 or have a value lower than the dealer's value, you will lose your bet.
