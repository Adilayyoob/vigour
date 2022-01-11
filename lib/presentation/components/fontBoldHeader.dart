// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class FontBoldHeader extends StatelessWidget {
  final String content;
  final double contentSize;
  const FontBoldHeader({required this.content, required this.contentSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Color.fromRGBO(51, 70, 105, 1),
        fontFamily: "Lato",
        fontWeight: FontWeight.w700,
        fontSize: contentSize,
      ),
    );
  }
}
