import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionWidget extends StatefulWidget {
  final String prototypeQuestion;
  final String translateQuestion;
  final String iconSvgPath; // Đường dẫn tới icon volume SVG (asset)

  const QuestionWidget({
    super.key,
    required this.prototypeQuestion,
    required this.translateQuestion,
    required this.iconSvgPath,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  double _textWidth = 0;
  final GlobalKey _textKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          _textKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        setState(() {
          _textWidth = renderBox.size.width;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width * 0.5;

    return Container(
      width: containerWidth,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(widget.iconSvgPath, width: 24, height: 24),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.prototypeQuestion,
                    key: _textKey,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: _textWidth,
                    height: 1,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFE5E5E5),
                          width: 1,
                          style: BorderStyle
                              .solid, // dashed không hỗ trợ trực tiếp
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 34),
            child: Text(
              widget.translateQuestion,
              style: const TextStyle(color: Color(0xFFB0B0B1)),
            ),
          ),
        ],
      ),
    );
  }
}
