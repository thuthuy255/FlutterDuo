import 'package:duolingo/components/header/header_lesson.dart';
import 'package:duolingo/stack/main_tab_navigation.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentStep = 0;
  int selectedIndex = -1;
  bool showFeedback = false;

  final Map<String, dynamic> lessonData = {
    "idLesson": 1007,
    "nameLesson": "Tranh luận: Cấu trúc cơ bản",
    "typeLesson": "Ngữ pháp",
    "questions": [
      {
        "idQuestion": 1004,
        "questionText": "Câu nào sau đây là câu tranh luận đúng cấu trúc?",
        "answers": [
          {"idAnswer": 1016, "answerText": "Hello", "isCorrect": true},
          {"idAnswer": 1017, "answerText": "This is blue", "isCorrect": false},
          {
            "idAnswer": 1018,
            "answerText": "My name is Thuy",
            "isCorrect": false,
          },
        ],
      },
      {
        "idQuestion": 1005,
        "questionText": "Từ nào sau đây dùng để mở đầu một lập luận?",
        "answers": [
          {"idAnswer": 1015, "answerText": "I am fine", "isCorrect": true},
          {"idAnswer": 1019, "answerText": "Chim", "isCorrect": false},
          {"idAnswer": 1020, "answerText": "Hello", "isCorrect": false},
        ],
      },
      {
        "idQuestion": 1008,
        "questionText": "What is your name?",
        "answers": [
          {"idAnswer": 1024, "answerText": "I am fine", "isCorrect": false},
          {"idAnswer": 1025, "answerText": "Hello", "isCorrect": false},
          {
            "idAnswer": 1026,
            "answerText": "My name is Thuy",
            "isCorrect": true,
          },
        ],
      },
    ],
  };

  int get totalSteps => lessonData['questions'].length;

  void _prevStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
        selectedIndex = -1;
        showFeedback = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void onSelect(int index) {
    if (showFeedback) return;
    setState(() {
      selectedIndex = index;
      showFeedback = true;
    });
  }

  void onContinue() {
    if (currentStep < totalSteps - 1) {
      setState(() {
        currentStep++;
        selectedIndex = -1;
        showFeedback = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainTabNavigation()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = lessonData['questions'] as List;
    final currentQuestion = questions[currentStep];
    final answers = currentQuestion['answers'] as List;

    final isLastStep = currentStep == totalSteps - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: HeaderLesson(
                percent: (currentStep + 1) / totalSteps,
                onPressGoBack: _prevStep,
                colorProgressBar: const Color(0xFF58CC02),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "CÂU HỎI ${currentStep + 1}/$totalSteps",
                style: const TextStyle(
                  color: Color(0xFFB36BE3),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                currentQuestion['questionText'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.separated(
                  itemCount: answers.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = answers[index];
                    final isSelected = selectedIndex == index;
                    final isCorrect = item['isCorrect'];

                    Color borderColor = Colors.grey.shade300;
                    Color? bgColor;

                    if (showFeedback && isSelected) {
                      borderColor = isCorrect ? Colors.green : Colors.red;
                      bgColor = isCorrect ? Colors.green[50] : Colors.red[50];
                    }

                    return GestureDetector(
                      onTap: () => onSelect(index),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: bgColor ?? Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: borderColor, width: 2),
                        ),
                        child: Text(
                          item['answerText'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (showFeedback)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: answers[selectedIndex]["isCorrect"]
                      ? const Color(0xFFD4F9C2)
                      : const Color(0xFFFFD6D6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          answers[selectedIndex]["isCorrect"]
                              ? "Excellent!"
                              : "Oops! Try again.",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: answers[selectedIndex]["isCorrect"]
                                ? const Color(0xFF58CC02)
                                : const Color(0xFFB00020),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          answers[selectedIndex]["isCorrect"]
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: answers[selectedIndex]["isCorrect"]
                              ? const Color(0xFF58CC02)
                              : const Color(0xFFB00020),
                          size: 24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF58CC02),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          shadowColor: Colors.green.shade200,
                        ),
                        child: Text(
                          isLastStep ? "DONE" : "CONTINUE",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
