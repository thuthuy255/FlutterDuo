import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonLesson extends StatefulWidget {
  final String status;
  final VoidCallback? onPress;
  final double size;

  const ButtonLesson({
    super.key,
    this.status = "unlock",
    this.onPress,
    this.size = 50,
  });

  @override
  State<ButtonLesson> createState() => _ButtonLessonState();
}

class _ButtonLessonState extends State<ButtonLesson>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool get isUnlocked => widget.status == 'unlock';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.6,
      upperBound: 1.0,
    );
    _scaleAnimation = _controller.drive(Tween(begin: 1.0, end: 0.6));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    _controller.reverse();
  }

  void _onTapUp(_) {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = isUnlocked
        ? const Color(0xFF57CC02)
        : const Color(0xFFE5E5E5);
    final backgroundColor = isUnlocked
        ? const Color(0xFF47A301)
        : const Color(0xFFB6B6B6);
    final iconAsset = isUnlocked
        ? 'assets/svg/iconStar.svg'
        : 'assets/svg/iconStarLock.svg';

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: () => _controller.forward(),
        onTap: isUnlocked ? widget.onPress : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 85,
              height: 78,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Container(
              width: 85,
              height: 70,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconAsset,
                  width: widget.size,
                  height: widget.size,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
