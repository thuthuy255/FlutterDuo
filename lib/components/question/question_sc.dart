import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionSCWidget extends StatelessWidget {
  final String prototypeQuestion;
  final String iconSvgPath;

  const QuestionSCWidget({
    super.key,
    required this.prototypeQuestion,
    required this.iconSvgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(iconSvgPath, width: 24, height: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prototypeQuestion,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Container(height: 1, color: const Color(0xFFE5E5E5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
