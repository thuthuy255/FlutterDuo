import 'package:duolingo/components/button/button_topic.dart';
import 'package:flutter/material.dart';
import 'package:duolingo/home/components/content_home.dart';
import 'package:duolingo/home/components/header_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? currentTopic;

  void handleNavigateHome() {
    Navigator.pushNamed(context, '/ProgressTopic');
  }

  void handleNavigateConversationLesson() {
    Navigator.pushNamed(context, '/ConversationLesson');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: HeaderHome(),
            ),

            const SizedBox(height: 20),

            // Nút chọn chủ đề
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ButtonTopic(
                itemNumberTopic: "PHẦN 1, CỬA 1",
                nameTopic: currentTopic?["nameTopic"] ?? "Chọn một chủ đề",
                iconBookAsset: 'assets/svg/icon_tab_navigation/icon_book.dart',
                onPressTopic: handleNavigateHome,
                onPressLesson: handleNavigateConversationLesson,
              ),
            ),

            const SizedBox(height: 20),

            // Nội dung bài học zigzag
            Expanded(
              child: ContentHome(
                setCurrentTopic: (topic) {
                  setState(() {
                    currentTopic = topic;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
