// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';

class StaticButtonSpacial extends StatelessWidget {
  final String heading;
  final String content;
  const StaticButtonSpacial({required this.heading, required this.content});

  @override
  Widget build(BuildContext context) {
    return ButtonSpecial(
      special: true,
      heading: heading,
      click: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(heading),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}