// different features button used in home screen
// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class HomeContainerButton extends StatelessWidget {
  final String content;
  final IconData iconName;
  final VoidCallback click;
  const HomeContainerButton(
      {required this.content, required this.iconName, required this.click});

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      borderRadius: 20,
      primaryColor: Theme.of(context).primaryColor,
      child: TextButton(
        onPressed: click,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 4,
            ),
            Icon(
              iconName,
              size: 50,
              color: const Color.fromRGBO(207, 111, 128, 1),
            ),
            const Spacer(
              flex: 2,
            ),
            Text(
              content,
              style: const TextStyle(
                color: Color.fromRGBO(207, 111, 128, 1),
                fontFamily: "Lato",
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
