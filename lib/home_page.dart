import 'dart:async';

import 'package:flappy_bird/barrier.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;
  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  bool isBirdDead() {
    //The bird collided with the edge of the Y-axis of the phone
    if (birdYAxis > 1 || birdYAxis < -1) return true;
    return false;
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      barrierXOne -= 0.05;
      barrierXTwo -= 0.05;
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;
      });
      setState(() {
        if (barrierXOne < -2) {
          barrierXOne += 3.5;
        } else {
          barrierXOne -= 0.01;
        }
      });
      setState(() {
        if (barrierXTwo < -2) {
          barrierXTwo += 3.5;
        } else {
          barrierXTwo -= 0.01;
        }
      });
      if (isBirdDead()) {
        timer.cancel();
        time = 0;
        birdYAxis = 0;
        initialHeight = 0;
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdYAxis),
                      color: Colors.blue,
                      duration: const Duration(milliseconds: 0),
                      child: const MyBird(),
                    ),
                    Container(
                      alignment: const Alignment(
                        0,
                        -0.2,
                      ),
                      child: gameHasStarted
                          ? const Text(" ")
                          : const Text(
                              'T A P  T O  P L A Y',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXOne, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXOne, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXTwo, 1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXTwo, -1.1),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 250.0,
                      ),
                    ),
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'SCORE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'BEST SCORE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '10',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
