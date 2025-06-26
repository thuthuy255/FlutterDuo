import 'package:duolingo/components/header/progress_bar_with_text.dart';
import 'package:flutter/material.dart';

class CourseEnglish extends StatelessWidget {
  final String title;
  final double progress;
  final String imageSource;
  final bool completed;

  const CourseEnglish({
    super.key,
    required this.title,
    required this.progress,
    required this.imageSource,
    this.completed = false,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: screenWidth * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.network(
              imageSource,
              width: double.infinity,
              height: screenWidth * 0.56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          // Title
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Progress or Label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: completed
                ? ProgressBarWithText(
                    percent: progress,
                    title: "0/7",
                    widthProgress: screenWidth * 0.8,
                    status: true,
                  )
                : const Text(
                    "Học vượt",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1CB0F6),
                    ),
                  ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
