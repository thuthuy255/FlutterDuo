import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang Chủ')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Fluttertoast.showToast(msg: "Đây là Toast thông báo!");
          },
          child: const Text('Hiển thị Toast'),
        ),
      ),
    );
  }
}
