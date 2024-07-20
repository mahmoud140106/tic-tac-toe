import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tic_tac/pages/play_page.dart';
import 'package:tic_tac/widgets/navigate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
            // GridView.count(
            //     physics: const NeverScrollableScrollPhysics(),
            //     padding: const EdgeInsets.all(16),
            //     mainAxisSpacing: 10.0,
            //     crossAxisSpacing: 10.0,
            //     childAspectRatio: 1.0,
            //     crossAxisCount: 2,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        CustomPageRoute(
                            page: const PlayPage(isTwoPlayer: false)),
                      )
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(20),
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 59, 121, 228),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'PLAY WITH COMPUTER',
                          style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        CustomPageRoute(
                            page: const PlayPage(isTwoPlayer: true)),
                      )
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 59, 121, 228),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'LOCAL MULTIPLAYER',
                          style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
