// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vigour/models/drinkWaterReminderModel.dart';
import 'package:vigour/models/service/preference_service.dart';
import 'package:vigour/notification/notification_api_water.dart';
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
  // initialising variables
  bool isSwitched = false;
  String weight = "";
  String noOfDays = "";
  String noOfDaysEntered = "Notification for how many Days?";
  String weightEntered = "Enter Your Weight (Kg)";
  bool reedOnly = false;
  String cups = "";

  final _preferenceService = PreferenceService();
  late FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    super.initState();
    _populateFields();
    NotificationApiWater.init();
    listenNotifications();
  }

  Future _populateFields() async {
    // getting previously stored data from shared preference
    final water = await _preferenceService.getWater();
    setState(() {
      isSwitched = water.switchStatus;
      weightEntered =
          water.weight.isEmpty ? "Enter Your Weight (Kg)" : water.weight;
      cups = water.cups;
      noOfDaysEntered =
          water.days.isEmpty ? "Notification for how many Days?" : water.days;
      print(water.weight.isEmpty);
    });
  }

  void toggleSwitch(bool value) {
    // toggle button actions
    if (isSwitched == false) {
      if (weight.isNotEmpty && noOfDays.isNotEmpty) {
        getNotified(calculateWater(weight));
        SnackBar snackBar = SnackBar(
          content: Text("Notification Turned On For $noOfDays Days!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          isSwitched = true;
          reedOnly = true;
        });
        _saveWater();
      } else {
        const snackBar = SnackBar(
          content:
              Text("Enter Your Weight and Notification for how many Days?!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      setState(() {
        weight = "";
        noOfDays = "";
        isSwitched = false;
        reedOnly = false;
      });
      _saveWater();
      NotificationApiWater.cancelAll();
    }
  }

  void getNotified(int n) {
    // Scheduling notification according to number of cups and for how many days
    int count = 1;
    String _timeNow = DateTime.now().toString();
    _timeNow = _timeNow.replaceRange(17, 26, "00.000000");
    DateTime _timeNowDT = DateTime.parse(_timeNow);
    _timeNowDT = _timeNowDT.add(const Duration(minutes: 1));
    for (int i = 0; i < int.parse(noOfDays); i++) {
      for (int j = 0; j < n; j++) {
        _timeNowDT = _timeNowDT.add(Duration(hours: 1));
        print("times: $_timeNowDT");
        NotificationApiWater.showScheduleNotification(
          id: count,
          title: 'Drink Water Reminder',
          body:
              'Its time to take a cup of water. (Todays target ${calculateWater(weight).toString()} cups of water.)',
          scheduledDate: _timeNowDT,
          payload: "$count",
        );
        count++;
      }
      _timeNowDT = _timeNowDT.add(const Duration(days: 1));
    }
  }

  int calculateWater(String weight) {
    // calculating number of cups of water according weight entered
    double waterInliter = double.parse(weight) * 0.033; 
    // As a general rule, you can use this simple calculation. Water (in litres) to drink a day = Your Weight (in Kg) multiplied by 0.033.
    double cups = waterInliter / 0.25;
    return cups.round();
  }

  // listen to a notification click
  void listenNotifications() => NotificationApiWater.onNotifivationsWater.stream
      .listen(notificationSelected);

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
              children: const [
                Spacer(
                  flex: 1,
                ),
                BackButtonNeo(),
                Spacer(
                  flex: 3,
                ),
                FontBoldHeader(
                    content: "Drink Water Reminder", contentSize: 18),
                Spacer(
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: InputField(
                keyboard: TextInputType.number,
                heading: noOfDaysEntered,
                pass: (value) {
                  noOfDays = value;
                  setState(() {
                    noOfDaysEntered = value;
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
    // runs when notification is clicked
    print(payload);
  }

  void _saveWater() {
    // saving data to shared preference
    final newWater = DrinkWaterReminderModel(
        weight: weight, switchStatus: isSwitched, cups: cups, days: noOfDays);
    _preferenceService.saveWater(newWater);
  }
}
