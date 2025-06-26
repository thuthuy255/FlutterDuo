import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputFormAuth extends StatefulWidget {
  final String name;
  final String? title;
  final String? placeholder;
  final double height;
  final bool secureTextEntry;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? errorText;
  final String? colorIcon;
  final String? strokeColorIcon;

  const InputFormAuth({
    super.key,
    required this.name,
    this.title,
    this.placeholder,
    this.height = 50,
    this.secureTextEntry = false,
    this.keyboardType,
    required this.controller,
    this.errorText,
    this.colorIcon,
    this.strokeColorIcon,
  });

  @override
  State<InputFormAuth> createState() => _InputFormAuthState();
}

class _InputFormAuthState extends State<InputFormAuth> {
  bool isSecure = true;

  @override
  void initState() {
    super.initState();
    isSecure = widget.secureTextEntry;
  }

  void toggleSecureTextEntry() {
    setState(() {
      isSecure = !isSecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: widget.errorText != null ? Colors.red : Colors.grey.shade400,
        width: 2,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 6),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              controller: widget.controller,
              obscureText: widget.secureTextEntry ? isSecure : false,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: widget.height > 53 ? 12 : 0,
                ),
                hintText: widget.placeholder,
                hintStyle: const TextStyle(color: Colors.grey),
                border: border,
                focusedBorder: border,
                enabledBorder: border,
                errorBorder: border,
              ),
              style: const TextStyle(color: Colors.black),
            ),
            if (widget.secureTextEntry)
              IconButton(
                icon: SvgPicture.string(arrowBackSvg, width: 20, height: 20),
                onPressed: toggleSecureTextEntry,
              ),
          ],
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}

/// SVG string converted from your provided icon
const String arrowBackSvg = '''
<svg fill="#000000" xmlns="http://www.w3.org/2000/svg" 
     width="800px" height="800px" viewBox="0 0 52 52" 
     enable-background="new 0 0 52 52" xml:space="preserve">
  <path d="M48.6,23H15.4c-0.9,0-1.3-1.1-0.7-1.7l9.6-9.6
           c0.6-0.6,0.6-1.5,0-2.1l-2.2-2.2c-0.6-0.6-1.5-0.6-2.1,0
           L2.5,25c-0.6,0.6-0.6,1.5,0,2.1L20,44.6c0.6,0.6,1.5,0.6,
           2.1,0l2.1-2.1c0.6-0.6,0.6-1.5,0-2.1l-9.6-9.6C14,30.1,
           14.4,29,15.3,29h33.2c0.8,0,1.5-0.6,1.5-1.4v-3C50,
           23.8,49.4,23,48.6,23z"/>
</svg>
''';
