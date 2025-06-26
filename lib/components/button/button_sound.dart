import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ButtonSound extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final String width; // bạn có thể sửa thành double nếu muốn linh hoạt hơn
  final Color shadowColor;
  final Color borderColor;
  final TextStyle? textStyle;

  const ButtonSound({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor = Colors.white,
    this.width = "85%", // dùng MediaQuery trong build
    this.shadowColor = const Color(0xFFE5E5E5),
    this.borderColor = const Color(0xFFE5E5E5),
    this.textStyle,
  });

  @override
  State<ButtonSound> createState() => _ButtonSoundState();
}

class _ButtonSoundState extends State<ButtonSound> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    try {
      await _audioPlayer.play(AssetSource('audio/click.wav'));
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
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    double widthButton;
    if (widget.width.contains('%')) {
      // Convert từ dạng 85% sang số double
      double percent = double.parse(widget.width.replaceAll('%', '')) / 100;
      widthButton = MediaQuery.of(context).size.width * percent;
    } else {
      widthButton = double.tryParse(widget.width) ?? 200;
    }

    return SizedBox(
      width: widthButton,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: widget.borderColor, width: 2),
          ),
          elevation: 5,
          shadowColor: widget.shadowColor,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: _handleClick,
        child: Text(
          widget.title,
          style:
              widget.textStyle ?? const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
