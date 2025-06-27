import 'package:flutter/material.dart';
import 'package:duolingo/components/question/question_sc.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int selectedIndex = -1;
  bool showFeedback = false;

  final List<Map<String, dynamic>> answers = [
    {"image": "assets/images/coffee.png", "label": "nước", "isCorrect": false},
    {"image": "assets/images/coffee.png", "label": "cà phê", "isCorrect": true},
    {"image": "assets/images/coffee.png", "label": "trà", "isCorrect": false},
    {"image": "assets/images/coffee.png", "label": "sữa", "isCorrect": false},
  ];

  void onSelect(int index) {
    if (showFeedback) return; // ngăn chọn lại khi đã chọn rồi

    setState(() {
      selectedIndex = index;
      showFeedback = true;
    });
  }

  void onContinue() {
    setState(() {
      selectedIndex = -1;
      showFeedback = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: LinearProgressIndicator(
                value: 0.25,
                backgroundColor: const Color(0xFFE5E5E5),
                color: const Color(0xFF58CC02),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "TỪ VỰNG MỚI",
                style: TextStyle(
                  color: Color(0xFFB36BE3),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Chọn hình ảnh đúng",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Image.asset("assets/icons/duo.png", height: 60, width: 60),
                  const SizedBox(width: 16),
                  Expanded(
                    child: QuestionSCWidget(
                      prototypeQuestion: "What kind of drink is this?",
                      iconSvgPath: "assets/icons/volume.svg",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.builder(
                  itemCount: answers.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
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
                        decoration: BoxDecoration(
                          color: bgColor ?? Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: borderColor, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(item["image"], height: 64),
                            const SizedBox(height: 8),
                            Text(
                              item["label"],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            if (showFeedback)
              Container(
                // margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: answers[selectedIndex]["isCorrect"]
                      ? const Color(0xFFD4F9C2) // xanh nhạt
                      : const Color(0xFFFFD6D6), // đỏ nhạt
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
                        child: const Text(
                          "CONTINUE",
                          style: TextStyle(
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
