import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderTopic extends StatelessWidget {
  final String iconXml; // SVG string
  final String uriImg;
  final VoidCallback? onPressGoBack;
  final String itemNumberTopic;
  final String nameTopic;
  final String title;

  const HeaderTopic({
    super.key,
    required this.iconXml,
    required this.uriImg,
    this.onPressGoBack,
    required this.itemNumberTopic,
    required this.nameTopic,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: onPressGoBack ?? () => Navigator.pop(context),
                child: SvgPicture.string(iconXml, width: 24, height: 24),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    uriImg,
                    width: width * 0.5,
                    height: width * 0.5,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    itemNumberTopic,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    nameTopic,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(color: Color(0xFFE5E5E5), thickness: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1CB0F6),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                nameTopic,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
