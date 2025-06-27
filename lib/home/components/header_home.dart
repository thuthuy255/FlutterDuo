// import 'package:duolingo/components/header/accumulate.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class HeaderHome extends StatelessWidget {
//   const HeaderHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Accumulate(
//             iconPath: 'assets/svg/icon_tab_navigation/icon_duoHeader.dart',

//           ),
//           Accumulate(
//             iconPath: 'assets/svg/icon_tab_navigation/icon_streak.dart',
//             onTap: () => Navigator.pushNamed(context, '/streak'),
//             count: 5,
//           ),
//           Accumulate(
//             iconPath: 'assets/svg/icon_tab_navigation/icon_diamond.dart',
//             count: 5,
//           ),
//           Accumulate(
//             iconPath: 'assets/svg/icon_tab_navigation/icon_heart.dart',
//             count: 5,
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:duolingo/components/header/accumulate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Đăng xuất"),
        content: const Text("Bạn có chắc chắn muốn đăng xuất?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Huỷ"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Đóng dialog
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
            child: const Text("Đăng xuất", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

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
            onTap: () => _showLogoutDialog(context),
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
