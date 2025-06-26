import 'package:duolingo/assets/svg/icon_tab_navigation/icon_badge.dart';
import 'package:duolingo/assets/svg/icon_tab_navigation/icon_lock.dart';
import 'package:duolingo/assets/svg/icon_tab_navigation/icon_remove_white.dart';
import 'package:duolingo/assets/svg/icon_tab_navigation/icon_share_white.dart';
import 'package:duolingo/assets/svg/icon_tab_navigation/icon_streak.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:duolingo/assets/svg/icon_tab_navigation/svg_assets.dart';
import 'package:duolingo/components/layout/streak_calendar.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Convert DateTime to String format 'yyyy-MM-dd'
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime(2025, 2, 6));
    final learnedDays = [
      DateTime(2025, 1, 6),
      DateTime(2025, 1, 7),
      DateTime(2025, 1, 12),
      DateTime(2025, 2, 2),
    ].map((e) => DateFormat('yyyy-MM-dd').format(e)).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              color: const Color(0xFFFE9515),
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Column(
                children: [
                  // Top buttons and title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: SvgPicture.asset(iconRemoveWhite),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const Text(
                          'Streak',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: SvgPicture.asset(iconShareWhite),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Day streak count
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "1",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "ngày Streak!",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(iconStreak),
                      ],
                    ),
                  ),
                  // Notification box
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(iconBadgeStreak),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Bạn đang có chuỗi streak dài nhất từ trước tới nay!',
                            style: TextStyle(height: 1.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Calendar title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lịch Streak',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Calendar
            StreakCalendar(currentDate: currentDate, learnedDays: learnedDays),

            // Streak Club title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hội Streak',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Streak Club info
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFE5E5E5), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(iconLock),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Đạt 7 ngày streak để gia nhập Hội Streak và nhận những phần thưởng độc quyền.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF777777),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
