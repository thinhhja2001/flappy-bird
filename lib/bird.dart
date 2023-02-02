import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  const MyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 60,
        child: Image.asset('assets/images/flappy_bird.png'));
  }
}
