// buttons used in this app.
// if special == false then pink colour button.
// is special == true then white neomorphic button.
// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable, import_of_legacy_library_into_null_safe, unused_import, unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class ButtonSpecial extends StatelessWidget {
  final String heading;
  final VoidCallback click;
  final bool special;
  const ButtonSpecial(
      {required this.heading, required this.click, this.special = false});

  @override
  Widget build(BuildContext context) {
    if (special == false) {
      return Container(
        height: 58,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColorDark),
        child: TextButton(
          onPressed: click,
          child: Text(
            heading,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Lato",
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
      );
    } else {
      return NeumorphicContainer(
        height: 58,
        width: MediaQuery.of(context).size.width,
        borderRadius: 20,
        primaryColor: Theme.of(context).primaryColor,
        child: TextButton(
          onPressed: click,
          child: Text(
            heading,
            style: TextStyle(
              color: Color.fromRGBO(51, 70, 105, 1),
              fontFamily: "Lato",
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
      );
    }
  }
}
