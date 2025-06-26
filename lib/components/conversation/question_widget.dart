import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionWidget extends StatefulWidget {
  final String prototypeQuestion;
  final String translateQuestion;
  // final String iconSvg;

  const QuestionWidget({
    super.key,
    required this.prototypeQuestion,
    required this.translateQuestion,
    // required this.iconSvg,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  double textWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * 0.5,
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
              // SvgPicture.string(widget.iconSvg, width: 24, height: 24),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final textPainter = TextPainter(
                        text: TextSpan(
                          text: widget.prototypeQuestion,
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
                            widget.prototypeQuestion,
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
                                      .solid, // Change to dashed with external lib if needed
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
              widget.translateQuestion,
              style: const TextStyle(color: Color(0xFFB0B0B1)),
            ),
          ),
        ],
      ),
    );
  }
}
