// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class AddButton extends StatelessWidget {
  final VoidCallback click;
  const AddButton({required this.click});

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      height: 52,
      width: 52,
      borderRadius: 30,
      primaryColor: Theme.of(context).primaryColor,
      child: IconButton(
        onPressed: click,
        icon: const Icon(
          Icons.add,
          color: Color.fromRGBO(51, 70, 105, 1),
          size: 36,
        ),
      ),
    );
  }
}
