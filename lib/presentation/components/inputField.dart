// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable, import_of_legacy_library_into_null_safe, unused_import, unused_field, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class InputField extends StatelessWidget {

  final String heading;
  final Function(String) pass;
  const InputField({required this.heading,required this.pass});
  
  @override
  Widget build(BuildContext context) {
    return  NeumorphicContainer(
            height: 58,
            width: 327,
            borderRadius: 20,
            primaryColor: Theme.of(context).primaryColor,
            curvature: Curvature.flat,
            spread: 5,
            child: TextField(
              onChanged: pass,
              cursorColor: Theme.of(context).primaryColorDark,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 20,top: 8),
                hintText: heading,
              ),
              style: TextStyle(
                color: Color.fromRGBO(51, 70, 105, 1),
                fontFamily: "Lato",
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          );
  }
}
