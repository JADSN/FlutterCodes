import 'package:flutter/material.dart';

class TextBoldCenter extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;

  const TextBoldCenter({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}
