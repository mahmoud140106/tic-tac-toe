import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tic_tac/pages/home_page.dart';
import 'package:tic_tac/pages/play_page.dart';
import 'package:tic_tac/constants.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static String id = 'SplashPage';
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientationDevice = MediaQuery.of(context).orientation;
    final screenHeight = MediaQuery.of(context).size.height;
    final appBar = AppBar();
    final bodyHeight = screenHeight -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.white,
            ],
            stops: [0.2, 0.8],
          ),
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 80,
                    // height: orientationDevice == Orientation.portrait ? 80 : 80,
                  ),
                  Image.asset(
                    kLogo,
                    // height: 220,
                    // width: 220,
                  ),
                  // SizedBox(
                  //   height: orientationDevice == Orientation.portrait
                  //       ? bodyHeight * 0.473
                  //       : 20,
                  // ),
                  // Text(
                  //   'Tic Tac'.toUpperCase(),
                  //   style: const TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 32,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: orientationDevice == Orientation.portrait
                  //       ? bodyHeight * 0.1
                  //       : 10,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
