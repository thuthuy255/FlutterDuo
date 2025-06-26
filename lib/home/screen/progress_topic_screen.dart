import 'package:duolingo/assets/svg/icon_tab_navigation/icon_remove.dart';
import 'package:duolingo/components/layout/course_english.dart';
import 'package:flutter/material.dart';
import '../../components/header/header_list.dart';

class ProgressTopicScreen extends StatelessWidget {
  const ProgressTopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              HeaderList(
                nameTopic: 'Khóa học Tiếng Anh',
                iconLeftSvg: iconRemove, // từ file icons.dart
              ),
              const SizedBox(height: 50),
              CourseEnglish(
                title: 'Phần 1',
                progress: 0.0,
                imageSource: 'assets/images/courseE1.png',
                completed: true,
              ),
              CourseEnglish(
                title: 'Phần 1',
                progress: 0.0,
                imageSource: 'assets/images/img_answer1.png',
                completed: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
