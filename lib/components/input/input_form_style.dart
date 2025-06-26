import 'package:flutter/material.dart';

final double screenWidth =
    WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width /
    WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

class InputFormStyle {
  static const inputTextColor = Color(0xFF111827);
  static const errorColor = Colors.red;
  static const inputBackground = Color(0xFFF9FAFB);
  static const borderColor = Color(0xFFE5E7EB);
  static const inputTextGray = Color(0xFF374151);

  static InputDecoration inputDecoration({
    String? hintText,
    bool hasError = false,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: hasError ? Colors.red : borderColor,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: hasError ? Colors.red : borderColor,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: hasError ? Colors.red : Colors.blue,
          width: 2,
        ),
      ),
    );
  }

  static const labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: inputTextColor,
  );

  static const errorTextStyle = TextStyle(
    fontSize: 14,
    color: errorColor,
    overflow: TextOverflow.ellipsis,
  );

  static const inputTextStyle = TextStyle(
    fontSize: 14,
    color: inputTextGray,
    height: 1.2,
  );

  static const inputContainer = BoxDecoration(
    color: inputBackground,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border.fromBorderSide(BorderSide(color: borderColor, width: 1)),
  );

  static const iconPadding = EdgeInsets.symmetric(horizontal: 10);

  static const checkBoxSize = Size(25, 25);
}
