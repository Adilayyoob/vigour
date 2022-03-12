// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class FontLightButton extends StatelessWidget {
  final String content;
  final double contentSize;
  final VoidCallback click;
  final bool red;
 FontLightButton({required this.content, required this.contentSize, required this.click, this.red = false});


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: click,
      child: Text(
        content,
        style: TextStyle(
          color: red? Colors.red :Color.fromRGBO(51, 70, 105, 0.5),
          fontFamily: "Lato",
          fontWeight: FontWeight.w400,
          fontSize: contentSize,
        ),
      ),
    );
  }
}
