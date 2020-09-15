[![View Code](https://img.shields.io/badge/View%20-Code-green)](https://github.com/berkovichpavel/ruby_course/tree/master/final_project)

<a text-align="center" href="#about">About</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#bw">Built With</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#ldl">Live Demo</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#mr">Mechanics and game rules</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#cd">Class Definitions</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#gs">Getting Started</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<a href="#author">Author</a>

# Back Jack game

This project is to demonstrate my knowledge of Object Oriented Programming Language in Ruby, building a Black Jack game on the command line where player can play with computer.

# About the Game - Black Jack <a name = "about"></a>

According to [Wikipedia](https://ru.wikipedia.org/wiki/%D0%91%D0%BB%D1%8D%D0%BA%D0%B4%D0%B6%D0%B5%D0%BA)
Blackjack is one of the most popular card games in casinos around the world.
 The great popularity of the game is due to simple rules, the speed of the game and the simplest card counting strategy.
  It is believed that the predecessor of this game was the card game "vingt-et-un" ("twenty-one"),
   which appeared in French gambling establishments around the 19th century. In Russia, for example,
    blackjack is still often called twenty-one or a point (but the traditional game of a point has slightly
     different rules).
     
## Built With <a name = "bw"></a>

- Ruby

## 🔴 Live Demo <a name = "ldl"></a>

[![Run on Repl.it](https://repl.it/badge/github/berkovichpavel/ruby_course)](https://rubycourse-1.berkovichpavel.repl.run)

## Mechanics and game rules <a name = "mr"></a>
- There is a player (user) and a dealer (controlled by the program).
- First, we ask the user for a name and then the game starts.
- When the game starts, the user and the dealer have $ 100 in the pot
- The user is given random 2 cards that he sees (cards are indicated by conventional notation, for example,
 "K +" - the king of crosses, "K <3" - the king of hearts, "K ^" - the king of spades,
  "K <>" - the king of diamonds etc. If you wish, you can use Unicode characters for the suits.)
- Also, 2 random cards are given to the "dealer" against whom the user is playing.
 The user does not see the dealer's cards, asterisks are shown instead.
- The user sees the sum of his points. The amount is calculated as follows: from 2 to 10 - at the face value of the card,
 all the "pictures" - 10 each, **ace - 1 or 11, depending on which value is closer to 21
  and what does not lead to a loss (the sum is more than 21)**.
- After the deal, a $ 10 bet is automatically placed in the game pot from the player and the dealer.
 (The player and the dealer deduct 10 from the bank)
- After that, the move goes to the user. The user has 3 options to choose from:
    - **Skip**. In this case, the turn goes to the dealer (see below)
    - **Add a map**. (only if the user has 2 cards in his hand). In this case, the player is added another random card, the sum of the points is recalculated, and the move goes to the dealer. Only one card can be added.
    - **Open maps**. The dealer's and the player's cards are revealed, the player sees the amount of the dealer's points, the game results are calculated (see below).
- The dealer's move (controlled by the program, the goal is to win, that is, to collect the amount of points as close as possible to 21). The dealer can:
    - **Skip a turn** (if the dealer has 17 or more points). The turn is transferred to the player.
    - **Add a card** (if the points are less than 17). The dealer has a new card (closed for the user). After that, the turn goes to the player. **Only one card can be added.**
- Players reveal their cards either when they reach 3 cards (automatically), or when the user selects the "Open cards" option. After that, the user sees the dealer's cards and the amount of his points, as well as the result of the game (who won and who lost).
Calculation of results:
    - The winner is the player whose score is closer to 21
    - If the player has more than 21 points, then he lost
    - If the sum of the points of the player and the dealer is the same, then a draw is declared and the money from the bank is returned to the players
    - The amount from the bank of the game goes to the winner
- After the end of the game, we ask the user if he wants to play again. If yes, then the game starts over from the deal of cards, if not, then we quit.

# Class Definitions <a name = "cd"></a>

### **Card class**:
Class for creating one card and determining its denomination. 

### **_Deck class_**:
A class for creating a deck of cards from all possible pairs (value, suit).

### **_Bill class_**:
Class for counting money from a player.

### **_User class_**:
A class for creating a user with his own name and bill, as well as for performing game actions that depend on the player.

### **_User interaction class_**:
Will interact with the game class to read the state of the game and display it.

### **_BlackJack Class_**:
This class will be responsible for the logic of the game. Reads the player's actions and provides the appropriate actions.


# Getting Started <a name = "gs"></a>

To get a local copy of the repository please run the following commands on your terminal:

```
$ cd <folder>

$ git clone https://github.com/berkovichpavel/ruby_course/tree/master/final_project.git
```

**To run the code:** 

~~~bash
$ ruby final_project/main.rb
~~~

# Author 

👤 **Berkovich Pavel**

- Github: [https://github.com/berkovichpavel](https://github.com/berkovichpavel)
- Telegram: [https://t.me/BerkovichPavel](https://t.me/BerkovichPavel)
- Linkedin: [https://www.linkedin.com/in/pavel-berkovich-9844251a4/](https://www.linkedin.com/in/pavel-berkovich-9844251a4/)
