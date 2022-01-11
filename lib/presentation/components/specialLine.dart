// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SpecialLine extends StatelessWidget {
  const SpecialLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Theme.of(context).primaryColorDark),
        ),
        const SizedBox(
          width: 16,
        ),
        Container(
          width: 243,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromRGBO(110, 129, 160, 0.24),
          ),
        )
      ],
    );
  }
}
