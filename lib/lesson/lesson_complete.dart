import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LessonCompleteScreen extends StatelessWidget {
  const LessonCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: SvgPicture.asset('assets/svg/icon_back.svg'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Row(
                    children: [
                      Image.network(
                        'https://i.giphy.com/media/xUA7b4jzIciCr73bP2/giphy.gif',
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                      ),
                      Image.network(
                        'https://i.giphy.com/media/xUA7b4jzIciCr73bP2/giphy.gif',
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Image.network(
              'https://i.giphy.com/media/QF5J9wUafbuI5g08FV/giphy.gif',
              width: 250,
              height: 250,
            ),
            const Text(
              'Lesson Complete!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFC234),
                fontSize: 25,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCard(
                  title: 'TOTAL XP',
                  icon: 'assets/image/total_xp.png',
                  value: '15',
                  color: const Color(0xFFFFD700),
                ),
                const SizedBox(width: 10),
                _buildCard(
                  title: 'AMAZING',
                  icon: 'assets/image/amazing.png',
                  value: '100%',
                  color: const Color(0xFF58CC02),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 16.0,
                  ),
                  backgroundColor: const Color(0xFF58CC02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/day-streak');
                },
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String icon,
    required String value,
    required Color color,
  }) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
        color: color,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(icon, width: 30, height: 30),
                const SizedBox(width: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
