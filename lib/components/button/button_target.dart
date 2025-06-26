import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BtnTarget extends StatefulWidget {
  final String textLeft;
  final String textRight;

  // Màu cho trạng thái chưa chọn và đã chọn
  final Color colorTextInactive;
  final Color colorTextActive;
  final Color backgroundColor;
  final Color backgroundColorActive;
  final Color borderColor;
  final Color borderColorActive;
  final Color shadowColor;
  final Color shadowColorActive;

  final bool status;
  final VoidCallback? onPress;

  const BtnTarget({
    super.key,
    required this.textLeft,
    required this.textRight,
    required this.colorTextInactive,
    this.colorTextActive = Colors.white, // ✅ Chữ khi được chọn: trắng
    this.backgroundColor = Colors.white, // ✅ Nền khi chưa chọn: trắng
    this.backgroundColorActive = const Color(0xFF58CC02), // ✅ Nền xanh Duolingo
    this.borderColor = const Color(0xFFE5E5E5), // ✅ Viền xám nhẹ khi chưa chọn
    this.borderColorActive = const Color(0xFF58A700), // ✅ Viền đậm hơn khi chọn
    this.shadowColor = const Color(0xFFEDEDED), // ✅ Đổ bóng nhẹ, nhẹ nhàng
    this.shadowColorActive = const Color(0xFF58A700), // ✅ Bóng đậm khi chọn
    this.status = false,
    this.onPress,
  });

  @override
  State<BtnTarget> createState() => _BtnTargetState();
}

class _BtnTargetState extends State<BtnTarget> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    try {
      await _audioPlayer.play(AssetSource('audio/click_button1.mp3'));
    } catch (e) {
      debugPrint('Lỗi phát âm thanh: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _handleClick() async {
    await _playSound();
    widget.onPress?.call();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.status
        ? widget.backgroundColorActive
        : widget.backgroundColor;
    final borderColor = widget.status
        ? widget.borderColorActive
        : widget.borderColor;
    final textColor = widget.status
        ? widget.colorTextActive
        : widget.colorTextInactive;
    final shadowColor = widget.status
        ? widget.shadowColorActive
        : widget.shadowColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: InkWell(
          onTap: _handleClick,
          borderRadius: BorderRadius.circular(13),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.textLeft,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  widget.textRight,
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
