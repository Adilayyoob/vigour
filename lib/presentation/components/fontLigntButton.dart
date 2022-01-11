// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class FontLightButton extends StatefulWidget {
  final String content;
  final double contentSize;
  final VoidCallback click;
 FontLightButton({required this.content, required this.contentSize, required this.click});

  @override
  _FontLightButtonState createState() => _FontLightButtonState();
}

class _FontLightButtonState extends State<FontLightButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.click,
      child: Text(
        widget.content,
        style: TextStyle(
          color: Color.fromRGBO(51, 70, 105, 0.5),
          fontFamily: "Lato",
          fontWeight: FontWeight.w400,
          fontSize: widget.contentSize,
        ),
      ),
    );
  }
}
