import 'dart:async';
import 'package:flutter/material.dart';

class FourthScreen extends StatefulWidget {
  const FourthScreen({super.key});

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup (FadeInUp equivalent)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Navigate to FifthScreen after 2 seconds
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        try {
          Navigator.pushReplacementNamed(context, 'fifth');
        } catch (e, stack) {
          debugPrint('🚨 Lỗi khi chuyển màn hình: $e');
          debugPrint('$stack');
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SlideTransition(
          position: _offsetAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                'https://media.giphy.com/media/1GOffIxX68NeJTerav/giphy.gif',
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 30),
              const Text(
                'ĐANG KHỞI TẠO KHÓA HỌC...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFA9A9A9),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sẵn sàng gia nhập cộng đồng ',
                      style: TextStyle(fontSize: 21, color: Color(0xFF4a4e69)),
                    ),
                    TextSpan(
                      text: '32',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Color(0xFF4a4e69),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: ' triệu người',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Color(0xFF4a4e69),
                      ),
                    ),
                    TextSpan(
                      text: ' đang học tiếng Anh',
                      style: TextStyle(fontSize: 21, color: Color(0xFF4a4e69)),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'trên Duolingo!',
                style: TextStyle(fontSize: 21, color: Color(0xFF4a4e69)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
