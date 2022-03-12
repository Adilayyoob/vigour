// Button used to go back to previous screen
// ignore_for_file: file_names, use_key_in_widget_constructors, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class BackButtonNeo extends StatelessWidget {
  const BackButtonNeo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      height: 40,
      width: 40,
      borderRadius: 30,
      primaryColor: Theme.of(context).primaryColor,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: Color.fromRGBO(110, 129, 160, 1),
        ),
      ),
    );
  }
}
