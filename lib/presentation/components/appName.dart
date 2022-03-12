// Display apps name 'Vigour'
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      "Vigour",
      style: TextStyle(
        color: Theme.of(context).primaryColorDark,
        fontFamily: "Leckerli One",
        fontSize: 36,
      ),
    );
  }
}
