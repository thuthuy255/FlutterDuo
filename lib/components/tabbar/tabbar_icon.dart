import 'package:duolingo/assets/svg/icon_tab_navigation/icon_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Giả sử bạn đã lưu nội dung SVG thành chuỗi giống như bên React Native
import 'package:duolingo/assets/svg/icon_tab_navigation/icon_home_page.dart';
import 'package:duolingo/assets/svg/icon_tab_navigation/icon_chest.dart';
import 'package:duolingo/assets/svg/icon_tab_navigation/icon_cup.dart';

class TabbarIcon extends StatelessWidget {
  final String name;

  const TabbarIcon({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    switch (name) {
      case 'Home':
        return SvgPicture.string(iconHomePage);
      case 'AboutScreen':
        return SvgPicture.string(iconChest);
      case 'NotificationScreen':
        return SvgPicture.string(iconNotification);
      case 'EmulationScreen':
        return SvgPicture.string(iconCup);
      default:
        return const SizedBox(); // fallback rỗng
    }
  }
}
