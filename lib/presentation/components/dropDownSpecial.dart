// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';

class DropDownSpecial extends StatelessWidget {
  
  final String heading;
  final Function(String?) click;
  final String selected;
  final List<String> items;
  DropDownSpecial({required this.heading,required this.selected,required this.items,required this.click});

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      height: 58,
      borderRadius: 20,
      primaryColor: Theme.of(context).primaryColor,
      curvature: Curvature.flat,
      spread: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 8,
            child: FontLightHeader(
              content: heading,
              contentSize: 20,
            ),
          ),
          const Spacer(
            flex: 3,
          ),
          DropdownButton(
            underline: DropdownButtonHideUnderline(child: Container()),
            value: selected,
            icon: Icon(Icons.keyboard_arrow_down,color: Theme.of(context).primaryColorDark,),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: click,
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
