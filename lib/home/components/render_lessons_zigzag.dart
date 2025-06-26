import 'package:flutter/material.dart';
import 'dart:math';

class RenderLessonsZigZag extends StatelessWidget {
  final List<Map<String, dynamic>> lessons;

  const RenderLessonsZigZag({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (int i = 0; i < lessons.length; i++) {
      final lesson = lessons[i];

      // Determine alignment and direction
      bool isCenter = i % 3 == 0;
      bool isLeft = i % 3 == 1;
      bool isRight = i % 3 == 2;

      // Add connecting line above (except for first)
      if (i != 0) {
        widgets.add(
          CustomPaint(
            size: const Size(double.infinity, 50),
            painter: _ConnectorPainter(
              fromLeft: isRight,
              fromRight: isLeft,
              isVertical: isCenter,
            ),
          ),
        );
      }

      // Add lesson node
      Widget node = Center(
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.green.shade400,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              lesson['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      if (isLeft) {
        widgets.add(
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [node]),
        );
      } else if (isRight) {
        widgets.add(
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [node]),
        );
      } else {
        widgets.add(node);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(children: widgets),
    );
  }
}

class _ConnectorPainter extends CustomPainter {
  final bool fromLeft;
  final bool fromRight;
  final bool isVertical;

  _ConnectorPainter({
    this.fromLeft = false,
    this.fromRight = false,
    this.isVertical = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.shade300
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();

    if (isVertical) {
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width / 2, size.height);
    } else if (fromLeft) {
      path.moveTo(0, 0);
      path.quadraticBezierTo(size.width / 2, size.height, size.width, 0);
    } else if (fromRight) {
      path.moveTo(size.width, 0);
      path.quadraticBezierTo(size.width / 2, size.height, 0, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
