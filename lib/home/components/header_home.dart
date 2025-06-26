import 'package:duolingo/components/header/accumulate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Accumulate(
            iconPath: 'assets/svg/icon_tab_navigation/icon_duoHeader.dart',
          ),
          Accumulate(
            iconPath: 'assets/svg/icon_tab_navigation/icon_streak.dart',
            onTap: () => Navigator.pushNamed(context, '/streak'),
            count: 5,
          ),
          Accumulate(
            iconPath: 'assets/svg/icon_tab_navigation/icon_diamond.dart',
            count: 5,
          ),
          Accumulate(
            iconPath: 'assets/svg/icon_tab_navigation/icon_heart.dart',
            count: 5,
          ),
        ],
      ),
    );
  }
}
