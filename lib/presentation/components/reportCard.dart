// individual report in report screen
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLight.dart';
import 'package:vigour/presentation/components/fontLightHeader.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final String time;
  final bool status;
  const ReportCard(
      {required this.title, required this.time, required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 3,
        ),
        Row(
          children: [
            const Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 32,
              child: FontLightHeader(content: title, contentSize: 18),
            ),
            Expanded(
              flex: 30,
              child: FontLightHeader(content: time, contentSize: 12),
            ),
            Expanded(
              flex: 5,
              child: status
                  ? const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.close_sharp,
                      color: Colors.red,
                    ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
        const SizedBox(
          height: 3,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
      ],
    );
  }
}
