import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonTopic extends StatelessWidget {
  final String itemNumberTopic;
  final String nameTopic;
  final VoidCallback? onPressTopic;
  final VoidCallback? onPressLesson;
  final String iconBookAsset; // đường dẫn tới SVG asset

  const ButtonTopic({
    super.key,
    required this.itemNumberTopic,
    required this.nameTopic,
    required this.iconBookAsset,
    this.onPressTopic,
    this.onPressLesson,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Nút trái
        Expanded(
          flex: 7,
          child: GestureDetector(
            onTap: onPressTopic,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Color(0xFF57CC02),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemNumberTopic,
                    style: const TextStyle(
                      color: Color(0xFFCAF3AE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    nameTopic,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Đường kẻ dọc
        Container(width: 3, height: 70, color: const Color(0xFF45A400)),

        // Nút phải
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: onPressLesson,
            child: Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFF57CC02),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconBookAsset,
                  width: 30,
                  height: 30,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFCCF2B1),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
