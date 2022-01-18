// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class HomeContainerButton extends StatefulWidget {
  final String content;
  final IconData iconName;
  final VoidCallback click;
  const HomeContainerButton({required this.content, required this.iconName,required this.click});

  @override
  _HomeContainerButtonState createState() => _HomeContainerButtonState();
}

class _HomeContainerButtonState extends State<HomeContainerButton> {
  
  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      borderRadius: 20,
      primaryColor: Theme.of(context).primaryColor,
      child: TextButton(
        onPressed: widget.click,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Spacer(
              flex: 4,
            ),
            Icon(
              widget.iconName,
              size: 50,
              color: const Color.fromRGBO(207, 111, 128, 1),
            ),
             const Spacer(
              flex: 2,
            ),
            Text(
              widget.content,
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
