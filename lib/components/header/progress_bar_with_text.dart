import 'package:flutter/material.dart';

class ProgressBarWithText extends StatelessWidget {
  final double percent;
  final Color? color;
  final String title;
  final double? widthProgress;
  final bool status;

  const ProgressBarWithText({
    super.key,
    this.percent = 0.7,
    this.color,
    required this.title,
    this.widthProgress,
    this.status = true,
  });

  Color getStatusColor() {
    return status ? (color ?? Colors.green) : const Color(0xFFE5E5E5);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final progressWidth = widthProgress ?? screenWidth * 0.6;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Background progress (gray)
        Container(
          width: progressWidth,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E5E5),
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        // Foreground progress (colored based on status)
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: progressWidth * percent,
            height: 20,
            decoration: BoxDecoration(
              color: getStatusColor(),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),

        // Centered text
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
