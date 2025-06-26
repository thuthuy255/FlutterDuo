import 'package:flutter/material.dart';

class ButtonLesson extends StatelessWidget {
  final String status; // "locked", "unlocked", "current", "done"
  final VoidCallback? onClick;
  const ButtonLesson({super.key, required this.status, this.onClick});

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = status
        .toLowerCase(); // để tránh lỗi viết hoa/thường
    final isLocked = normalizedStatus == 'locked';

    Color backgroundColor;
    Color borderColor;
    Widget icon;

    switch (normalizedStatus) {
      case 'current':
        backgroundColor = const Color(0xFF4EB602); // xanh Duolingo
        borderColor = const Color(0xFF4EB602);
        icon = const Icon(Icons.star, color: Colors.white, size: 30);
        break;

      case 'unlocked':
        backgroundColor = const Color(0xFF4EB602); // nền xanh lá
        borderColor = const Color(0xFF4EB602); // cùng màu để viền không lộ
        icon = const Icon(
          Icons.star_border,
          color: Colors.white, // icon trắng
          size: 30,
        );
        break;

      case 'done':
        backgroundColor = const Color(0xFFB3E56D); // xanh nhạt
        borderColor = const Color(0xFF4EB602);
        icon = const Icon(Icons.check, color: Colors.white, size: 26);
        break;

      case 'locked':
      default:
        backgroundColor = Colors.grey.shade300;
        borderColor = Colors.grey.shade400;
        icon = const Icon(Icons.lock_outline, color: Colors.grey, size: 26);
        break;
    }

    return GestureDetector(
      onTap: isLocked
          ? null
          : () {
              // TODO: Xử lý khi nhấn vào nút
              debugPrint("Lesson [$status] clicked");
              if (onClick != null) {
                onClick!(); // ✅ gọi callback
              }
            },
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 3),
          boxShadow: isLocked
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
        ),
        child: Center(child: icon),
      ),
    );
  }
}
