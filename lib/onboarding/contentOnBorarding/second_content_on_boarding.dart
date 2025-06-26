import 'package:duolingo/components/button/button_list.dart';
import 'package:duolingo/dataFake/static_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SecondContentOnBoarding extends StatefulWidget {
  const SecondContentOnBoarding({super.key});

  @override
  State<SecondContentOnBoarding> createState() =>
      _SecondContentOnBoardingState();
}

class _SecondContentOnBoardingState extends State<SecondContentOnBoarding> {
  int? selectedLevel;

  void handleSelected(int id) {
    setState(() {
      selectedLevel = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: StaticData.level.map((item) {
          return Animate(
            key: ValueKey(item['id']),
            effects: const [FadeEffect(), SlideEffect()],
            child: ButtonList(
              text: item['level'],
              linkImg: item['image'],
              onPress: () => handleSelected(item['id']),
              status: selectedLevel == item['id'],
            ),
          );
        }).toList(),
      ),
    );
  }
}
