import 'package:duolingo/components/button/button_list.dart';
import 'package:duolingo/dataFake/static_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ThirdContentOnBoarding extends StatefulWidget {
  const ThirdContentOnBoarding({super.key});

  @override
  State<ThirdContentOnBoarding> createState() => _ThirdContentOnBoardingState();
}

class _ThirdContentOnBoardingState extends State<ThirdContentOnBoarding> {
  int? selectedPurpose;

  void handleSelected(int id) {
    setState(() {
      selectedPurpose = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: StaticData.dataPurpose.map((item) {
          return Animate(
            key: ValueKey(item['id']),
            effects: const [FadeEffect(), SlideEffect()],
            child: ButtonList(
              text: item['toDo'],
              linkImg: item['image'],
              onPress: () => handleSelected(item['id']),
              status: selectedPurpose == item['id'],
            ),
          );
        }).toList(),
      ),
    );
  }
}
