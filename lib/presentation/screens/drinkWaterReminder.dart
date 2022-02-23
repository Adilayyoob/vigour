// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vigour/database/vigourDB.dart';
import 'package:vigour/models/drinkWaterReminderModel.dart';
import 'package:vigour/models/service/preference_service.dart';
import 'package:vigour/notification/notification_api.dart';
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
  bool isSwitched = false;
  String weight = "";
  String weightEntered = "Enter Your Weight (Kg)";
  bool reedOnly = false;
  String cups = "";
 
  final _preferenceService = PreferenceService();
  late FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    super.initState();
    _populateFields();
    NotificationApi.init();
    listenNotifications();
  }

  Future _populateFields() async {
    final water = await _preferenceService.getWater();
    setState(() {
      isSwitched = water.switchStatus;
      weightEntered = water.weight;
      cups = water.cups;
      print(water.weight.isEmpty);
    });
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      if (weight.isNotEmpty) {
        getNotified(calculateWater(weight));
        
        setState(() {
          isSwitched = true;
          reedOnly = true;
        });
        _saveWater();
      } else {
        final snackBar = SnackBar(
          content: Text("Enter Your Weight!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
     
      setState(() {
        isSwitched = false;
        reedOnly = false;
      });
       _saveWater();
    }
  }

  Future<void> getNotified(int n) async {
    do {
      for (int i = 0; i < n; i++) {
        await Future.delayed(const Duration(hours: 1), () {});
        NotificationApi.showScheduleNotification(
          title: 'Drink Water Reminder',
          body:
              'Its time to take a cup of water. (Todays target ${calculateWater(weight).toString()} cups of water.)',
          scheduledDate: DateTime.now().add(const Duration(seconds: 1)),
        );
      }
      await Future.delayed(const Duration(days: 1), () {});
    } while (n != null);
  }

  int calculateWater(String weight) {
    double waterInliter = double.parse(weight) * 0.033;
    double cups = waterInliter / 0.25;
    return cups.round();
  }

  void listenNotifications() =>
      NotificationApi.onNotifivations.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).pushNamed('/WelcomeScreen');

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
            Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: SwitchButton(
                  content: "Notification",
                  isSwitched: isSwitched,
                  toggleSwitch: toggleSwitch,
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: InputField(
                keyboard: TextInputType.number,
                heading: weightEntered,
                pass: (value) {
                  weight = value;
                  setState(() {
                    weightEntered = value;
                  });
                },
                reedOnly: reedOnly,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future notificationSelected(String? payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  void _saveWater() {
    final newWater = DrinkWaterReminderModel(
        weight: weight.isEmpty?weightEntered="Enter Your Weight (Kg)":weight, switchStatus: isSwitched, cups: cups);
    _preferenceService.saveWater(newWater);
  }
}
