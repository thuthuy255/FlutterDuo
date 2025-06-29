import 'package:audioplayers/audioplayers.dart';
import 'package:duolingo/components/header/header_lesson.dart';
import 'package:duolingo/stack/main_tab_navigation.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  final Map<String, dynamic> lessonData;

  const QuestionScreen({super.key, required this.lessonData});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentStep = 0;
  int selectedIndex = -1;
  bool showFeedback = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<dynamic> get questions => widget.lessonData['questions'] ?? [];
  int get totalSteps => questions.length;

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

  void playAudio(String url) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      debugPrint('Lỗi phát âm thanh: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Không có câu hỏi nào trong bài học này.")),
      );
    }

    final question = questions[currentStep];
    final answers = question['answers'] ?? [];
    final isLastStep = currentStep == totalSteps - 1;
    final audioUrl = question['audioUrl']?.toString() ?? '';

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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  if (audioUrl.isNotEmpty)
                    GestureDetector(
                      onTap: () => playAudio(audioUrl),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF58CC02),
                        ),
                        child: const Icon(Icons.volume_up, color: Colors.white),
                      ),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      question['questionText']?.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
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
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    final item = answers[index];
                    final isSelected = selectedIndex == index;
                    final isCorrect = item['isCorrect'] == true;

                    Color borderColor = Colors.grey.shade300;
                    Color? bgColor;

                    if (showFeedback && isSelected) {
                      borderColor = isCorrect ? Colors.green : Colors.red;
                      bgColor = isCorrect ? Colors.green[50] : Colors.red[50];
                    } else if (isSelected) {
                      borderColor = const Color(0xFF58A1FF);
                      bgColor = const Color(0xFFE7F0FF);
                    }

                    return GestureDetector(
                      onTap: () => onSelect(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: bgColor ?? Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: borderColor, width: 2),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (item['imagePath'] != null &&
                                item['imagePath'].toString().isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item['imagePath'],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 12),
                            Text(
                              item['answerText']?.toString() ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
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
            if (showFeedback && selectedIndex >= 0)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: answers[selectedIndex]['isCorrect']
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
                          answers[selectedIndex]['isCorrect']
                              ? "Excellent!"
                              : "Oops! Try again.",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: answers[selectedIndex]['isCorrect']
                                ? const Color(0xFF58CC02)
                                : const Color(0xFFB00020),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          answers[selectedIndex]['isCorrect']
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: answers[selectedIndex]['isCorrect']
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
