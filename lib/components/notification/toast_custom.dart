import 'package:flutter/material.dart';

enum ToastType { success, error, info }

const ERROR_DEFAULT = Color(0xFFE57373); // đỏ nhạt
const SUCCESS_DEFAULT = Color(0xFF81C784); // xanh lá
const WARNING_DEFAULT = Color(0xFFFFB74D); // cam

class ToastCustom extends StatelessWidget {
  final String? text1;
  final String? text2;
  final ToastType typeStatus;

  const ToastCustom({
    super.key,
    this.text1,
    this.text2,
    this.typeStatus = ToastType.info,
  });

  Color getColor() {
    switch (typeStatus) {
      case ToastType.error:
        return ERROR_DEFAULT;
      case ToastType.success:
        return SUCCESS_DEFAULT;
      case ToastType.info:
      default:
        return WARNING_DEFAULT;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(width: 8, color: color)),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (text1 != null)
                  Text(
                    text1!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                if (text2 != null)
                  Text(
                    text2!,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
