// Thinner font headings used in app
// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class FontLightHeader extends StatelessWidget {
  final String content;
  final double contentSize;
  final int numberOfLines;
  final Color colour;
  const FontLightHeader(
      {required this.content,
      required this.contentSize,
      this.numberOfLines = 1,
      this.colour = const Color.fromRGBO(51, 70, 105, 1)});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      overflow: TextOverflow.ellipsis,
      maxLines: numberOfLines,
      style: TextStyle(
        color: colour,
        fontFamily: "Lato",
        fontWeight: FontWeight.w400,
        fontSize: contentSize,
      ),
    );
  }
}
