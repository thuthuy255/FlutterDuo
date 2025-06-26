import 'package:duolingo/components/button/button_sound.dart';
import 'package:duolingo/components/header/header_lesson.dart';
import 'package:duolingo/components/header/tutorial_widget.dart';
import 'package:duolingo/onboarding/contentOnBorarding/fifth_onboarding_screen.dart';
import 'package:duolingo/onboarding/contentOnBorarding/first_onboarding_screen.dart';
import 'package:duolingo/onboarding/contentOnBorarding/fourth_content_onboarding.dart';
import 'package:duolingo/onboarding/contentOnBorarding/second_content_on_boarding.dart';
import 'package:duolingo/onboarding/contentOnBorarding/third_content_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:duolingo/constants/colors.dart';

class FifthScreen extends StatefulWidget {
  const FifthScreen({super.key});

  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  final PageController _pageController = PageController();
  int currentStep = 0;

  final List<Map<String, dynamic>> steps = [
    {
      'message': 'Bạn biết tới Duolingo từ đâu?',
      'content': const FirstContentOnBoarding(),
    },
    {
      'message': 'Trình độ Tiếng Anh của bạn ở mức nào?',
      'content': const SecondContentOnBoarding(),
    },
    {
      'message': 'Được rồi, mình cùng học từ cơ bản nhé?',
      'content': const ThirdContentOnBoarding(),
    },
    {
      'message': 'Cùng chinh phục các kì thi bạn nhé?',
      'content': const FourthContentOnBoarding(),
    },
    {
      'message': 'Hãy cùng lên kế hoạch học tập nhé!',
      'content': const FifthContentOnBoarding(),
    },
  ];

  void _nextStep() {
    if (currentStep + 1 < steps.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentStep += 1;
      });
    } else {
      Navigator.pushReplacementNamed(context, "/main");
    }
  }

  void _prevStep() {
    if (currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentStep -= 1;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              // Thanh tiến trình và nút quay lại
              HeaderLesson(
                percent: (currentStep + 1) / steps.length,
                onPressGoBack: _prevStep,
              ),
              const SizedBox(height: 10),

              // Câu hỏi hướng dẫn
              Animate(
                effects: const [FadeEffect(), SlideEffect()],
                child: TutorialWidget(
                  linkImg: 'assets/images/omnom.png',
                  text: steps[currentStep]['message'],
                ),
              ),

              // Nội dung chính (các bước trong PageView)
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: steps.length,
                  itemBuilder: (_, index) {
                    return steps[index]['content']; // ❌ Không cần bọc Padding nữa
                  },
                ),
              ),

              // Nút tiếp tục
              SizedBox(
                height: screenHeight * 0.12,
                child: Center(
                  child: Animate(
                    effects: const [FadeEffect(), ScaleEffect()],
                    child: ButtonSound(
                      title: 'TIẾP TỤC',
                      onPressed: _nextStep,
                      backgroundColor: const Color(0xFF58CC02),
                      shadowColor: const Color(0xFF58A700),
                      borderColor: const Color(0xFF58CC02),
                      textStyle: const TextStyle(
                        color: TEXT_COLORS_DARK,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
