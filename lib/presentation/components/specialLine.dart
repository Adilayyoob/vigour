// A special line with 70% pink and 20% white colour
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SpecialLine extends StatelessWidget {
  const SpecialLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).primaryColorDark),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 16,
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color.fromRGBO(110, 129, 160, 0.24),
            ),
          ),
        )
      ],
    );
  }
}
