// Thinner font used in app
// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class FontLight extends StatelessWidget {
  final String content;
  final double contentSize;
  const FontLight({
    required this.content,
    required this.contentSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        color: Color.fromRGBO(51, 70, 105, 0.5),
        fontFamily: "Lato",
        fontWeight: FontWeight.w400,
        fontSize: contentSize,
      ),
    );
  }
}
