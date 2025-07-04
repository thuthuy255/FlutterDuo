import 'package:duolingo/dataFake/data_lesson.dart';
import 'package:duolingo/home/services/home.api.dart';
import 'package:duolingo/until/toast_util.dart';

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
    if (dataLesson.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.setCurrentTopic(dataLesson[0]);
      });
    }
  }

  Future<void> _loadTopics() async {
    try {
      final response = await TopicService.getAllTopic(); // Truyền body nếu cần
      if (response['success'] == true && response['data'] is List) {
        final List rawTopics = response['data'];
        topics = rawTopics
            .map(
              (topic) => {
                'nameTopic': topic['topicName'],
                'listLessons': topic['lessons'] ?? [],
              },
            )
            .toList();

        if (topics.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.setCurrentTopic(topics[0]);
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
    widget.setCurrentTopic(topic);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          final offset = _scrollController.offset;
          const itemHeight = 200.0;
          final index = (offset / itemHeight).floor();
          if (index >= 0 && index < dataLesson.length) {
            _onItemVisible(dataLesson[index]);
          }
        }
        return true;
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 20, bottom: 100),
        itemCount: dataLesson.length,
        itemBuilder: (context, index) {
          final topic = dataLesson[index];
          final rawLessons = topic['listLessons'];

          final listLessons = rawLessons is List
              ? rawLessons.whereType<Map<String, dynamic>>().toList()
              : <Map<String, dynamic>>[];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListLesson(listLesson: listLessons),
              ),
              // Tiêu đề chủ đề nằm giữa dòng kẻ
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
                        topic['nameTopic'] ?? 'Tên chủ đề',
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

              // Danh sách bài học
            ],
          );
        },
      ),
    );
  }
}
