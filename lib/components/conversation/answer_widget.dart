import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnswerWidget extends StatefulWidget {
  final String prototypeAnswer;
  final String translateAnswer;
  // final String iconSvg; // SVG string (giống icon_volume)

  const AnswerWidget({
    super.key,
    required this.prototypeAnswer,
    required this.translateAnswer,
    // required this.iconSvg,
  });

  @override
  State<AnswerWidget> createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  double textWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // SvgPicture.string(widget.iconSvg, height: 24, width: 24),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final textPainter = TextPainter(
                          text: TextSpan(
                            text: widget.prototypeAnswer,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                        )..layout();

                        textWidth = textPainter.size.width;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.prototypeAnswer,
                              style: const TextStyle(fontSize: 16),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              width: textWidth,
                              height: 1,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xFFE5E5E5),
                                    width: 1,
                                    style: BorderStyle
                                        .solid, // Dotted/dashed not native
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                widget.translateAnswer,
                style: const TextStyle(color: Color(0xFFB0B0B1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
