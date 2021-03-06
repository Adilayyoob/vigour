// card used for medicine reminder, Doctor visit reminder and Document upload area
// if visibleTime == true reminderTime will be visible
// if masterCardColour == true card for coloured pill reminder is visible
// if masterCardColour == true card for coloured pill reminder is visible

// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLight.dart';
import 'package:vigour/presentation/components/fontLightHeader.dart';

class TheMasterCard extends StatelessWidget {
  final VoidCallback click;
  final VoidCallback longclick;
  final String date;
  final String title;
  final String documentFileName;
  final String reminderTime;
  final VoidCallback delete;
  final bool visibleTime;
  final bool masterCardColour;
  final Color colourPill;
  final bool status;
  const TheMasterCard({
    required this.click,
    required this.longclick,
    required this.date,
    required this.title,
    required this.documentFileName,
    required this.delete,
    this.reminderTime = "0:00 PM",
    this.visibleTime = true,
    this.masterCardColour = false,
    this.colourPill = const Color.fromRGBO(207, 111, 128, 1),
    this.status = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!masterCardColour) {
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
            onLongPress: longclick,
            onTap: click,
            child: NeumorphicContainer(
              spread: status ? 0 : 6,
              height: 58,
              borderRadius: 20,
              primaryColor:
                  status ? Colors.greenAccent : Theme.of(context).primaryColor,
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
                      FontLightHeader(content: title, contentSize: 18),
                      FontLight(
                        content: documentFileName,
                        contentSize: 14,
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
    } else {
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
          Row(
            children: [
              NeumorphicContainer(
                height: 58,
                width: 58,
                borderRadius: 20,
                primaryColor: Theme.of(context).primaryColor,
                child: Icon(
                  FontAwesomeIcons.capsules,
                  color: colourPill,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 20,
                child: GestureDetector(
                  onTap: click,
                  onLongPress: longclick,
                  child: NeumorphicContainer(
                    spread: status ? 0 : 6,
                    height: 58,
                    borderRadius: 20,
                    primaryColor: status
                        ? Colors.greenAccent
                        : Theme.of(context).primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        Expanded(
                          flex: 27,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FontLightHeader(content: title, contentSize: 18),
                              FontLight(
                                content: documentFileName,
                                contentSize: 14,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Expanded(
                          flex: 27,
                          child: Visibility(
                            visible: visibleTime,
                            child: FontLightHeader(
                              content: reminderTime,
                              contentSize: 24,
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 10,
                          child: IconButton(
                              onPressed: delete,
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30,
                              )),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}
