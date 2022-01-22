// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/switchButton.dart';

class DrinkWaterReminderScreen extends StatefulWidget {
  DrinkWaterReminderScreen({Key? key}) : super(key: key);

  @override
  _DrinkWaterReminderScreenState createState() =>
      _DrinkWaterReminderScreenState();
}

class _DrinkWaterReminderScreenState extends State<DrinkWaterReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const Spacer(
                  flex: 1,
                ),
                BackButtonNeo(),
                const Spacer(
                  flex: 3,
                ),
                const FontBoldHeader(
                    content: "Drink Water Reminder", contentSize: 18),
                const Spacer(
                  flex: 6,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: SwitchButton(content: "Notification")),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child:
                    InputField(heading: "Enter Your Weight", pass: (value) {})),
          ],
        ),
      ),
    );
  }
}
