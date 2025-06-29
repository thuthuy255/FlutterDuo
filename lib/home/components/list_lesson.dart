import 'package:duolingo/components/button_lesson.dart';
import 'package:duolingo/question/question.dart';
import 'package:duolingo/services/api_service.dart';
import 'package:flutter/material.dart';

class ListLesson extends StatelessWidget {
  final List<Map<String, dynamic>> listLesson;
  final String topicStatus;
  final Function(Map<String, dynamic>)? onLessonClick;

  const ListLesson({
    super.key,
    required this.listLesson,
    required this.topicStatus,
    this.onLessonClick,
  });

  double getTranslateX(int index) {
    final waveOffsets = [0.0, -0.1, 0.1, -0.08, 0.08, -0.06, 0.06];
    return waveOffsets[index % waveOffsets.length];
  }

  void handleLessonClick(BuildContext context, Map<String, dynamic> lesson) {
    if (onLessonClick != null) {
      onLessonClick!(lesson);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLocked = topicStatus == 'lock';

    return Column(
      children: listLesson.asMap().entries.map((entry) {
        final index = entry.key;
        final lesson = entry.value;
        final offsetX = screenWidth * getTranslateX(index);
        final status = isLocked ? 'locked' : 'unlocked';

        return Transform.translate(
          offset: Offset(offsetX, 0),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 25),
            child: ButtonLesson(
              status: status,
              onClick: isLocked
                  ? null
                  : () => handleLessonClick(context, lesson),
            ),
          ),
        );
      }).toList(),
    );
  }
}
