import 'package:duolingo/components/button_lesson.dart';
import 'package:flutter/material.dart';

class ListLesson extends StatelessWidget {
  final List<Map<String, dynamic>> listLesson;

  const ListLesson({super.key, required this.listLesson});

  /// Dịch chuyển sóng: bắt đầu ở giữa rồi zigzag trái/phải
  double getTranslateX(int index) {
    final waveOffsets = [0.0, -0.1, 0.1, -0.08, 0.08, -0.06, 0.06, -0.04, 0.04];
    final waveIndex = index % waveOffsets.length;
    return waveOffsets[waveIndex];
  }

  /// ✅ Hàm xử lý khi nhấn vào bài học
  void onLessonClick(Map<String, dynamic> lesson) {
    debugPrint("🟢 Clicked Lesson: ${lesson['title']} (id: ${lesson['id']})");
    // TODO: Bạn có thể chuyển màn hoặc xử lý logic tại đây
    // Navigator.pushNamed(context, '/lessonDetail', arguments: lesson);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: listLesson.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        final status = (item['status'] is String)
            ? item['status'] as String
            : 'locked';

        final offsetX = screenWidth * getTranslateX(index);

        return Transform.translate(
          offset: Offset(offsetX, 0),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 25),
            child: ButtonLesson(
              status: status,
              onClick: () => onLessonClick(item),
            ),
          ),
        );
      }).toList(),
    );
  }
}
