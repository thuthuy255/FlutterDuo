import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { success, error, warning, info }

class ToastUtil {
  static void show(String message, {ToastType type = ToastType.info}) {
    Color bgColor;

    switch (type) {
      case ToastType.success:
        bgColor = Colors.green;
        break;
      case ToastType.error:
        bgColor = Colors.red;
        break;
      case ToastType.warning:
        bgColor = Colors.orange;
        break;
      case ToastType.info:
      default:
        bgColor = Colors.blueGrey;
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      backgroundColor: bgColor,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
    );
  }
}


// cách dùng 


// // Thành công
// ToastUtil.show("Đăng ký thành công!", type: ToastType.success);

// // Lỗi
// ToastUtil.show("Mật khẩu xác nhận không khớp!", type: ToastType.error);

// // Cảnh báo
// ToastUtil.show("Vui lòng nhập đầy đủ thông tin", type: ToastType.warning);
