import 'package:duolingo/components/screenOnBoarding/animated_intro_block.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedIntroBlock(
      message: 'Chào bạn! Tớ là Om Nom!',
      gifUrl: 'https://media.giphy.com/media/yc0iGEK3Az6sH2yIqU/giphy.gif',
      buttonText: 'CONTINUE',
      onPress: () {
        Navigator.pushNamed(context, 'thirst'); // hoặc MaterialPageRoute
      },
    );
  }
}
