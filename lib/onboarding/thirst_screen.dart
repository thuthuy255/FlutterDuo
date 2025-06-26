import 'package:duolingo/components/screenOnBoarding/animated_intro_block.dart';
import 'package:flutter/material.dart';

class ThirstScreen extends StatelessWidget {
  const ThirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // ✅ Set màu nền trắng
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: AnimatedIntroBlock(
          message:
              'Chỉ 7 câu hỏi nhỏ trước khi chúng ta bắt đầu bài học đầu tiên!',
          gifUrl: 'https://media.giphy.com/media/QF5J9wUafbuI5g08FV/giphy.gif',
          buttonText: 'CONTINUE',
          onPress: () {
            Navigator.of(context).pushNamed('fourth');
          },
        ),
      ),
    );
  }
}
