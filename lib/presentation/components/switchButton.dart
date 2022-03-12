// toggle button or switch button
// ignore_for_file: prefer_const_constructors_in_immutables, file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';

class SwitchButton extends StatelessWidget {
  final String content;
  final bool isSwitched;
  final Function(bool) toggleSwitch;
  const SwitchButton(
      {required this.content,
      required this.isSwitched,
      required this.toggleSwitch});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FontBoldHeader(content: content, contentSize: 24),
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
