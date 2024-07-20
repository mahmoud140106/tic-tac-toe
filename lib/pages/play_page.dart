import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac/game_logic.dart';

class PlayPage extends StatefulWidget {
  final bool isTwoPlayer;
  const PlayPage({super.key, required this.isTwoPlayer});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  late ConfettiController _controllerCenter;

  void resetGame() {
    setState(() {
      Player.playerX = [];
      Player.playerO = [];
      activePlayer = 'X';
      gameOver = false;
      turn = 0;
      result = '';
    });
  }

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    resetGame();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  void celebrateWin() {
    _controllerCenter.play();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 52,
                    ),
                    children: [
                      if (!gameOver && turn > 0)
                        TextSpan(
                          text: 'It\'s '.toUpperCase(),
                        ),
                      if (!gameOver && turn > 0)
                        TextSpan(
                          text: activePlayer.toUpperCase(),
                          style: TextStyle(
                            color: activePlayer == 'X'
                                ? Colors.blueAccent
                                : Colors.pink,
                          ),
                        ),
                      if (!gameOver && turn > 0)
                        TextSpan(
                          text: ' turn'.toUpperCase(),
                        ),
                      if (gameOver)
                        TextSpan(
                          text: ' Game end'.toUpperCase(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 1.0,
                    crossAxisCount: 3,
                    children: List.generate(
                      9,
                      (index) => InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: gameOver ? null : () => _onTap(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).shadowColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              Player.playerX.contains(index)
                                  ? 'X'
                                  : Player.playerO.contains(index)
                                      ? 'O'
                                      : '',
                              style: TextStyle(
                                color: Player.playerX.contains(index)
                                    ? Colors.blueAccent
                                    : Colors.pink,
                                fontSize: 52,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                result != ''
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            result == 'It\'s Draw!'
                                ? const Text(
                                    'It\'s Draw!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 42,
                                    ),
                                  )
                                : Container(),
                            result != 'It\'s Draw!'
                                ? RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 42,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: result.toUpperCase(),
                                          style: TextStyle(
                                            color: result == 'X'
                                                ? Colors.blueAccent
                                                : Colors.pink,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: ' is the winner',
                                        ),
                                      ],
                                    ),
                                  )
                                : const Text(""),
                          ],
                        ),
                      )
                    : const SizedBox(height: 0),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: resetGame,
                  icon: const Icon(Icons.replay),
                  label: const Text(
                    'Repeat the game',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).splashColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 140,
                ),
              ],
            ),
            result != '' && result != 'It\'s Draw!'
                ? ConfettiWidget(
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: false,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple,
                    ],
                    createParticlePath: drawStar,
                    emissionFrequency: 0.0001,
                    numberOfParticles: 150,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);
      updateState();
      if (!widget.isTwoPlayer && !gameOver && turn != 9) {
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() {
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        gameOver = true;
        result = winnerPlayer;
        _controllerCenter.play();
      } else if (!gameOver && turn == 9) {
        result = 'It\'s Draw!';
      }
    });
  }
}
