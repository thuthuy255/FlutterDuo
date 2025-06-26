import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../components/button/button_list.dart';
import '../../../dataFake/static_data.dart';

class FirstContentOnBoarding extends StatefulWidget {
  const FirstContentOnBoarding({super.key});

  @override
  State<FirstContentOnBoarding> createState() => _FirstContentOnBoardingState();
}

class _FirstContentOnBoardingState extends State<FirstContentOnBoarding> {
  int? selectedSocial;

  void handleSelected(int id) {
    setState(() {
      selectedSocial = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: StaticData.dataSocial
            .map(
              (item) => Animate(
                effects: const [FadeEffect(), SlideEffect()],
                child: ButtonList(
                  text: item['social'],
                  linkImg: item['Image'],
                  onPress: () => handleSelected(item['id']),
                  status: selectedSocial == item['id'],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
