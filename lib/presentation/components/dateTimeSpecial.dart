// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';

class DateTimeSpecial extends StatelessWidget {
  final String heading;
  final Function(DateTime) click;
  final bool date;
  DateTimeSpecial(
      {required this.heading, required this.click, this.date = false});

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
            flex: 12,
            child: FontLightHeader(
              content: heading,
              contentSize: 20,
            ),
          ),
          const Spacer(
            flex: 3,
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              icon: !date
                  ? Icon(
                      FontAwesomeIcons.clock,
                      color: Theme.of(context).primaryColorDark,
                    )
                  : Icon(
                      FontAwesomeIcons.calendar,
                      color: Theme.of(context).primaryColorDark,
                    ),
              onPressed: () {
                if (!date) {
                  DatePicker.showTime12hPicker(context,
                      showTitleActions: true,
                      onConfirm: click,
                      currentTime: DateTime.now().add(const Duration(minutes: 1)));
                } else {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      onConfirm: click,
                      currentTime: DateTime.now().add(const Duration(minutes: 1)));
                }
              },
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
