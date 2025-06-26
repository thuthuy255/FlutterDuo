import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { success, error, info }

class ShowToastCustom {
  static void show({
    required String text1,
    String? text2,
    ToastType typeStatus = ToastType.info,
  }) {
    Color bgColor;
    switch (typeStatus) {
      case ToastType.success:
        bgColor = Colors.green;
        break;
      case ToastType.error:
        bgColor = Colors.red;
        break;
      case ToastType.info:
      default:
        bgColor = Colors.blue;
        break;
    }

    Fluttertoast.showToast(
      msg: text2 != null ? "$text1\n$text2" : text1,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: bgColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
