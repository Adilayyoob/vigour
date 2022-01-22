// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';

class TheMasterCard extends StatelessWidget {
  final VoidCallback click;
  final String date;
  final String title;
  final String documentFileName;
  final String reminderTime;
  final VoidCallback delete;
  final bool visibleTime;
  const TheMasterCard({required this.click,required this.date,required this.title,required this.documentFileName,required this.delete,this.reminderTime="0:00 PM",this.visibleTime=true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
         FontLight(content: date, contentSize: 14),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: click,
          child: NeumorphicContainer(
            height: 58,
            borderRadius: 20,
            primaryColor: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(
                  flex: 3,
                ),
                    FontLightHeader(content: title, contentSize: 18),
                    FontLight(
                      content: documentFileName,
                      contentSize: 14,
                    ),
                    const Spacer(
                  flex: 6,
                ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
                Visibility(
                  visible: visibleTime,
                  child: FontLightHeader(
                    content: reminderTime,
                    contentSize: 24,
                  ),
                ),
                 const Spacer(
                  flex: 2,
                ),
                IconButton(
                    onPressed: delete,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    )),
                     const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
