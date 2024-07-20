import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension ListContainsAllExtension<T> on List<T> {
  bool containsAll(List<T> elements) {
    return elements.every((element) => contains(element));
  }
}

class Game {
  void playGame(int index, String activePlayer) {
    if (activePlayer == 'X') {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  String checkWinner() {
    String winner = '';
    if (Player.playerX.containsAll([0, 1, 2]) ||
        Player.playerX.containsAll([3, 4, 5]) ||
        Player.playerX.containsAll([6, 7, 8]) ||
        Player.playerX.containsAll([0, 3, 6]) ||
        Player.playerX.containsAll([1, 4, 7]) ||
        Player.playerX.containsAll([2, 5, 8]) ||
        Player.playerX.containsAll([0, 4, 8]) ||
        Player.playerX.containsAll([2, 4, 6])) {
      winner = 'X';
    } else if (Player.playerO.containsAll([0, 1, 2]) ||
        Player.playerO.containsAll([3, 4, 5]) ||
        Player.playerO.containsAll([6, 7, 8]) ||
        Player.playerO.containsAll([0, 3, 6]) ||
        Player.playerO.containsAll([1, 4, 7]) ||
        Player.playerO.containsAll([2, 5, 8]) ||
        Player.playerO.containsAll([0, 4, 8]) ||
        Player.playerO.containsAll([2, 4, 6])) {
      winner = 'O';
    } else if (Player.playerX.length + Player.playerO.length == 9) {
      winner = 'It\'s Draw!';
    } else {
      winner = '';
    }
    return winner;
  }

  //function to evaluate the board
  int evaluateBoard() {
    String winner = checkWinner();
    if (winner == 'X') return 10;
    if (winner == 'O') return -10;
    return 0;
  }

  // function to check if there are moves left
  bool isMovesLeft() {
    for (int i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        return true;
      }
    }
    return false;
  }

  // Minimax function
  int minimax(int depth, bool isMax) {
    int score = evaluateBoard();

    // If the maximizer has won the game return his/her evaluated score
    if (score == 10) return score - depth;

    // If the minimizer has won the game return his/her evaluated score
    if (score == -10) return score + depth;

    // If there are no more moves and no winner then it is a draw
    if (!isMovesLeft()) return 0;

    // If this is maximizer's move
    if (isMax) {
      int best = -1000;

      for (int i = 0; i < 9; i++) {
        if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
          Player.playerX.add(i);
          best = max(best, minimax(depth + 1, !isMax));
          Player.playerX.remove(i);
        }
      }
      return best;
    }
    // If this is minimizer's move
    else {
      int best = 1000;

      for (int i = 0; i < 9; i++) {
        if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
          Player.playerO.add(i);
          best = min(best, minimax(depth + 1, !isMax));
          Player.playerO.remove(i);
        }
      }
      return best;
    }
  }

  // autoPlay function to use the Minimax algorithm
  Future<void> autoPlay(String activePlayer) async {
    int bestVal = activePlayer == 'X' ? -1000 : 1000;
    int bestMove = -1;

    for (int i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        if (activePlayer == 'X') {
          Player.playerX.add(i);
          int moveVal = minimax(0, false);
          Player.playerX.remove(i);

          if (moveVal > bestVal) {
            bestMove = i;
            bestVal = moveVal;
          }
        } else {
          Player.playerO.add(i);
          int moveVal = minimax(0, true);
          Player.playerO.remove(i);

          if (moveVal < bestVal) {
            bestMove = i;
            bestVal = moveVal;
          }
        }
      }
    }
    playGame(bestMove, activePlayer);
  }
}
