// Thinner font in red colour used in app
// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class FontLightRed extends StatelessWidget {
  final String content;
  final double contentSize;
  const FontLightRed({
    required this.content,
    required this.contentSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        color: Theme.of(context).primaryColorDark,
        fontFamily: "Lato",
        fontWeight: FontWeight.w400,
        fontSize: contentSize,
      ),
    );
  }
}
