import 'package:flutter/material.dart';

class ButtonList extends StatelessWidget {
  final String text;
  final String linkImg;
  final VoidCallback onPress;
  final bool status;

  const ButtonList({
    super.key,
    required this.text,
    required this.linkImg,
    required this.onPress,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        color: status ? Colors.blue.shade50 : Colors.white,
        border: Border.all(
          color: status ? Colors.blue : Colors.grey.shade300,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: status ? Colors.blue.shade100 : Colors.grey.shade200,
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: Row(
            children: [
              Image.asset(linkImg, width: 40, height: 40),
              const SizedBox(width: 20),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: status ? Colors.blue : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
