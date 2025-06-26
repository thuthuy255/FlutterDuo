import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Accumulate extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onTap;
  final int? count;

  const Accumulate({super.key, required this.iconPath, this.onTap, this.count});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Icon chính
          SvgPicture.asset(iconPath, width: 36, height: 36),

          // Badge hiển thị số ở góc trên bên phải
          if (count != null && count! > 0)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 114, 114),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
