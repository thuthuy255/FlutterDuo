import 'package:duolingo/assets/svg/icon_tab_navigation/icon_profile.dart';
import 'package:duolingo/main_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:duolingo/assets/svg/icon_tab_navigation/svg_assets.dart';
import 'package:duolingo/components/header/header_list.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    void handleNavigatePageHome() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderList(nameTopic: 'Bảng tin'),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF1CB0F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.6,
                        child: const Text(
                          'Tạo hồ sơ để xem cập nhật của bạn bè',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                      ),
                      SvgPicture.asset(iconProfile),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        bottom: BorderSide(
                          color: const Color(0xFF84D7FF),
                          width: 4,
                        ),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Bắt Đầu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1CB1F5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Notification content 1
            _buildNotificationCard(
              context,
              imagePath: 'assets/images/courseE1.png',
              time: '6 tiếng',
              message:
                  'Chào mừng bạn tới với Bảng tin! Tại đây bạn có thể chúc mừng thành tích của bạn bè và thông tin về sản phẩm, các mẹo học tập và nhiều điều khác!',
            ),
            // Notification content 2 with button
            _buildNotificationCard(
              context,
              imagePath: 'assets/images/courseE1.png',
              time: '6 tiếng',
              message:
                  'Hoàn thành một bài học mỗi ngày để giữ vững chuỗi streak!',
              hasButton: true,
              onButtonPressed: handleNavigatePageHome,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context, {
    required String imagePath,
    required String time,
    required String message,
    bool hasButton = false,
    VoidCallback? onButtonPressed,
  }) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE6E5E1), width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              imagePath,
              height: width * 0.6,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: const TextStyle(color: Color(0xFFAFAFAF))),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                if (hasButton && onButtonPressed != null) ...[
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: onButtonPressed,
                    child: Container(
                      width: width * 0.4,
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFE2E2E2),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          'Bắt Đầu Học',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1CB1F5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
