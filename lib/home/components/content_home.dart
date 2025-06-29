import 'package:duolingo/home/services/home.api.dart';
import 'package:duolingo/until/toast_util.dart';
import 'package:duolingo/question/question.dart';
import 'package:flutter/material.dart';
import 'list_lesson.dart';

class ContentHome extends StatefulWidget {
  final Function(Map<String, dynamic>) setCurrentTopic;

  const ContentHome({super.key, required this.setCurrentTopic});

  @override
  State<ContentHome> createState() => _ContentHomeState();
}

class _ContentHomeState extends State<ContentHome> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> topics = [];

  @override
  void initState() {
    super.initState();
    _loadTopics();
  }

  Future<void> _loadTopics() async {
    try {
      final response = await TopicService.getAllTopic();
      if (response['success'] == true && response['data'] is List) {
        final List rawTopics = response['data'];
        topics = rawTopics
            .whereType<Map<String, dynamic>>()
            .map(
              (topic) => {
                'idTopic': topic['topicId'] ?? '',
                'topicName': topic['topicName']?.toString() ?? 'Tên chủ đề',
                'status': topic['isLocked']?.toString() ?? 'lock',
                'listLessons': topic['lessons'] ?? [],
              },
            )
            .toList();

        final unlockedTopic = topics.firstWhere(
          (t) => t['status'] == 'unlock',
          orElse: () => {},
        );
        if (unlockedTopic.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.setCurrentTopic(unlockedTopic);
          });
        }

        setState(() {});
      } else {
        ToastUtil.show('Dữ liệu không hợp lệ', type: ToastType.warning);
      }
    } catch (e) {
      ToastUtil.show('Lỗi khi tải topics: $e', type: ToastType.error);
    }
  }

  void _onItemVisible(Map<String, dynamic> topic) {
    if ((topic['status']?.toString() ?? '') == 'unlock') {
      widget.setCurrentTopic(topic);
    }
  }

  void _onLessonClick(Map<String, dynamic> lesson) async {
    final lessonId = lesson['lessonId'] ?? lesson['lessonID'];
    if (lessonId == null) {
      ToastUtil.show('Bài học không hợp lệ!', type: ToastType.error);
      return;
    }

    try {
      final res = await TopicService.getLessonDetail(lessonId);
      if (res['success'] == true && res['data'] != null) {
        final lessonData = res['data'];
        final questions = lessonData['questions'] as List? ?? [];

        final hasValid = questions.any((q) {
          final answers = q['answers'] as List?;
          return answers != null && answers.isNotEmpty;
        });

        if (!hasValid) {
          ToastUtil.show(
            'Bài học chưa có câu trả lời hợp lệ!',
            type: ToastType.warning,
          );
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuestionScreen(lessonData: lessonData),
          ),
        );
      } else {
        ToastUtil.show(
          res['message'] ?? 'Không thể tải bài học',
          type: ToastType.error,
        );
      }
    } catch (e) {
      ToastUtil.show('Lỗi khi tải chi tiết bài học: $e', type: ToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          final offset = _scrollController.offset;
          const itemHeight = 200.0;
          final index = (offset / itemHeight).floor();
          if (index >= 0 && index < topics.length) {
            _onItemVisible(topics[index]);
          }
        }
        return true;
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 20, bottom: 100),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          final listLessons =
              (topic['listLessons'] as List?)
                  ?.whereType<Map<String, dynamic>>()
                  .toList() ??
              [];
          final topicName = topic['topicName']?.toString() ?? 'Tên chủ đề';
          final topicStatus = topic['status']?.toString() ?? 'lock';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListLesson(
                  listLesson: listLessons,
                  topicStatus: topicStatus,
                  onLessonClick: _onLessonClick,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.grey.shade300, thickness: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        topicName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 171, 170, 170),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.grey.shade300, thickness: 1),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
