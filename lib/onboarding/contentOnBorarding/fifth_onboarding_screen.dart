import 'package:flutter/material.dart';
import 'package:duolingo/auth/register_screen.dart';

class FifthContentOnBoarding extends StatefulWidget {
  const FifthContentOnBoarding({super.key});

  @override
  State<FifthContentOnBoarding> createState() => _FifthContentOnBoardingState();
}

class _FifthContentOnBoardingState extends State<FifthContentOnBoarding> {
  String? selectedOption;

  void handlePressOption(String option) {
    setState(() {
      selectedOption = option;
    });

    if (option == 'beginner') {
      Navigator.of(context, rootNavigator: true).pushNamed('/register');
    } else if (option == 'intermediate') {
      Navigator.of(context, rootNavigator: true).pushNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                // BEGINNER
                Container(
                  padding: const EdgeInsets.all(25),
                  width: MediaQuery.of(context).size.width * 0.81,
                  decoration: BoxDecoration(
                    color: selectedOption == 'beginner'
                        ? const Color(0xFFE5F8D9)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: selectedOption == 'beginner'
                          ? const Color(0xFF58CC02)
                          : const Color(0xFFE5E5E5),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () => handlePressOption('beginner'),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/book_one.png',
                              width: 70,
                              height: 70,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Đây là lần đầu tiên bạn học Tiếng Anh?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Bắt đầu từ bài tập cơ bản nhé!',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -40,
                        right: -35,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1CB0F6),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Text(
                            'ĐỀ XUẤT',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // INTERMEDIATE
                GestureDetector(
                  onTap: () => handlePressOption('intermediate'),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    width: MediaQuery.of(context).size.width * 0.81,
                    decoration: BoxDecoration(
                      color: selectedOption == 'intermediate'
                          ? const Color(0xFFE5F8D9)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: selectedOption == 'intermediate'
                            ? const Color(0xFF58CC02)
                            : const Color(0xFFE5E5E5),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/compass.png',
                          width: 70,
                          height: 70,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Bạn đã biết một chút Tiếng Anh?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Chúng mình cùng tìm điểm khởi đầu phù hợp nhé!',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
