// ignore_for_file: prefer_const_constructors_in_immutables, file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';

class SwitchButton extends StatefulWidget {
  final String content;
  const SwitchButton({required this.content});

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FontBoldHeader(content: widget.content, contentSize: 24),
        const Spacer(
         flex: 1,
        ),
        Switch(
          value: isSwitched,
          onChanged: toggleSwitch,
          activeColor: Theme.of(context).primaryColorDark,
        ),
      ],
    );
  }
}
