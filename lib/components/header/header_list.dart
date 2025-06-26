import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderList extends StatelessWidget {
  final VoidCallback? onPressGoBack;
  final String nameTopic;
  final String? iconLeftSvg;
  final String? iconRightSvg;

  const HeaderList({
    super.key,
    this.onPressGoBack,
    required this.nameTopic,
    this.iconLeftSvg,
    this.iconRightSvg,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Nút trái
              Positioned(
                left: 16,
                child: IconButton(
                  onPressed: onPressGoBack ?? () => Navigator.pop(context),
                  icon: iconLeftSvg != null
                      ? SvgPicture.string(iconLeftSvg!)
                      : const Icon(Icons.arrow_back),
                ),
              ),

              // Tiêu đề
              Center(
                child: Text(
                  nameTopic,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFAFAFAF),
                  ),
                ),
              ),

              // Nút phải
              Positioned(
                right: 16,
                child: iconRightSvg != null
                    ? IconButton(
                        onPressed:
                            onPressGoBack ?? () => Navigator.pop(context),
                        icon: SvgPicture.string(iconRightSvg!),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),

        // Line dưới
        const Divider(color: Color(0xFFE5E5E5), thickness: 1.5, height: 1.5),
      ],
    );
  }
}
