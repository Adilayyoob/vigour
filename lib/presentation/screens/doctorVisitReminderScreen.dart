// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/database/vigourDB.dart';
import 'package:vigour/models/doctorVisitReminderModel.dart';
import 'package:vigour/notification/notification_api.dart';
import 'package:vigour/presentation/components/addButton.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/dateTimeSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLightRed.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:vigour/presentation/components/theMasterCard.dart';

class DoctorVisitReminderScreen extends StatefulWidget {
  DoctorVisitReminderScreen({Key? key}) : super(key: key);

  @override
  _DoctorVisitReminderScreenState createState() =>
      _DoctorVisitReminderScreenState();
}

class _DoctorVisitReminderScreenState extends State<DoctorVisitReminderScreen> {
  // initialising variables
  bool popDrawVis = false;
  bool isLoading = false;
  late List<DoctorVisitReminderModel> doctors;
  late DoctorVisitReminderModel doctors2;
  late DoctorVisitReminderModel doctors3;
  String doctorName = "";
  String location = "";
  String date = "";
  bool status = false;
  String timeHeading = "Date & Time";

  @override
  void initState() {
    super.initState();

    refreshDoctor();
    NotificationApi.init();
    listenNotifications();
  }

  Future refreshDoctor() async {
    // fetching data from database
    setState(() => isLoading = true);
    this.doctors = await VigourDatabase.instance.readAllDoctor();
    setState(() => isLoading = false);
  }

  Future addDoctor() async {
    // adding an item to database
    final doctor = DoctorVisitReminderModel(
        name: doctorName, date: date, location: location, status: status);

    doctors3 = await VigourDatabase.instance.createDoctor(doctor);
  }

  String formatTime(String t) {
    // Converting DateTime to 24 hours format
    DateTime tempDate = DateTime.parse(t);
    String formattedTime = DateFormat.jm().format(tempDate);
    return formattedTime;
  }

  String formatDate(String t) {
    // Converting DateTime to date only format
    DateTime tempDate = DateTime.parse(t);
    String formattedDate = DateFormat('dd-MM-yyyy').format(tempDate);
    return formattedDate;
  }

  String convertHourMinute(DateTime t) {
    // Converting DateTime to hour:minute format
    String formatTime = DateFormat('HH:mm').format(t).toString();
    return formatTime;
  }

  void getNotified(DoctorVisitReminderModel d) {
    // adding a notification
    DateTime tempDate = DateTime.parse(d.date);
    print("id=${d.id!}");
    NotificationApi.showScheduleNotification(
      id: d.id!,
      title: 'Doctor Visit Reminder',
      body:
          'Its time to visit ${d.name} at ${d.location}. (Click to record visit to report)',
      payload: "${d.id!}",
      scheduledDate: tempDate,
    );
  }

  // listen to a notification click
  void listenNotifications() =>
      NotificationApi.onNotifivations.stream.listen(notificationSelected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                primary: false,
                padding: const EdgeInsets.only(top: 0),
                children: [
                  Column(
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
                              content: "Doctor Visit Reminder",
                              contentSize: 18),
                          Spacer(
                            flex: 6,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: isLoading
                            ? Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              )
                            : doctors.isEmpty
                                ? const Center(
                                    child: FontLightRed(
                                        content: "No Doctor Visits Found",
                                        contentSize: 14),
                                  )
                                : buildDoctor(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 25,
                right: 20,
                child: AddButton(
                  click: () {
                    setState(() {
                      popDrawVis = true;
                    });
                  },
                )),
            Visibility(
              visible: popDrawVis,
              child: Positioned(
                bottom: 0,
                child: DoctorAdd(
                  timeHeading: timeHeading,
                  doctorName: (value) {
                    doctorName = value;
                    print(value);
                  },
                  location: (value) {
                    location = value;
                  },
                  date: (value) {
                    date = value.toString();
                    setState(() {
                      timeHeading = "${formatDate(date)} [${formatTime(date)}]";
                    });
                  },
                  reminderButton: () {
                    if ((doctorName.isEmpty) || (date.isEmpty)) {
                      const snackBar = SnackBar(
                        content: Text(
                            "Enter atleast 'Doctor Name' and 'Date & Time'"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      // adding doctor data to database and retrieving data then waiting for 2 second and scheduling notification
                      // waiting for 2 second is to retrieving id used to store in database
                      addDoctor();

                      refreshDoctor();

                      Timer(const Duration(seconds: 2), () {
                        getNotified(doctors3);
                      });

                      setState(() {
                        popDrawVis = false;
                        doctorName = "";
                        location = "";
                      });
                    }
                  },
                  cancelButton: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      popDrawVis = false;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDoctor() => ListView.builder(
        // building master card for each doctor data item in database
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return TheMasterCard(
            longclick: () async {
              // changing status true when master card is long clicked after reminder time is over
              DateTime now = DateTime.now();
              DateTime _tempDate = DateTime.parse(doctor.date);
              if (now.compareTo(_tempDate) > 0) {
                final doc2 = DoctorVisitReminderModel(
                    id: doctor.id,
                    name: doctor.name,
                    date: doctor.date,
                    location: doctor.location,
                    status: true);
                await VigourDatabase.instance.updateDoctor(doc2);
                refreshDoctor();
              }
            },
            click: () {
              // Time picker to change time
              DatePicker.showTime12hPicker(context, showTitleActions: true,
                  onConfirm: (time) async {
                NotificationApi.cancel(doctor.id!);
                String time2 = time.toString();
                time2 = time2.replaceRange(11, 16, convertHourMinute(time));
                DateTime _tempDate = DateTime.parse(time2);
                print("time2=$time2");
                // updating purticular data in database
                final doc2 = DoctorVisitReminderModel(
                    id: doctor.id,
                    name: doctor.name,
                    date: time2,
                    location: doctor.location,
                    status: false);
                await VigourDatabase.instance.updateDoctor(doc2);
                refreshDoctor();
                // rescheduling notification
                NotificationApi.showScheduleNotification(
                  id: doctor.id!,
                  title: 'Doctor Visit Reminder',
                  body:
                      'Its time to visit ${doctor.name} at ${doctor.location}. (Click to record visit to report)',
                  payload: "${doctor.id!}",
                  scheduledDate: _tempDate,
                );
              }, currentTime: DateTime.now().add(const Duration(minutes: 1)));
            },
            date: formatDate(doctor.date),
            title: doctor.name,
            documentFileName: doctor.location,
            delete: () => showDialog<String>(
              // dialogue box to confirm delete
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const FontBoldHeader(content: "Delete", contentSize: 18),
                content: FontLightRed(
                    content:
                        "Do you want to delete the visit with ${doctor.name}?",
                    contentSize: 14),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await VigourDatabase.instance.deleteDoctor(doctor.id!);
                      NotificationApi.cancel(doctor.id!);

                      Navigator.pop(context, 'OK');
                      refreshDoctor();
                      setState(() {});
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            visibleTime: true,
            reminderTime: formatTime(doctor.date),
            status: doctor.status,
          );
        },
      );

  Future notificationSelected(String? payload) async {
    // changing status true when notification is clicked
    for (int i = 0; i < doctors.length; i++) {
      if (doctors[i].id == int.parse(payload!)) {
        doctors2 = doctors[i];
        final doc = DoctorVisitReminderModel(
            id: doctors2.id,
            name: doctors2.name,
            date: doctors2.date,
            location: doctors2.location,
            status: true);
        print(payload);
        await VigourDatabase.instance.updateDoctor(doc);
        refreshDoctor();
      }
    }
  }
}

class DoctorAdd extends StatefulWidget {
  // adding doctor info UI
  final Function(String) doctorName;
  final Function(String) location;
  final Function(DateTime) date;
  final VoidCallback reminderButton;
  final VoidCallback cancelButton;
  final String doctorNameini;
  final String locationini;
  final String timeHeading;

  DoctorAdd({
    required this.doctorName,
    required this.location,
    required this.date,
    required this.reminderButton,
    required this.cancelButton,
    this.doctorNameini = "",
    this.locationini = "",
    required this.timeHeading,
  });

  @override
  _DoctorAddState createState() => _DoctorAddState();
}

class _DoctorAddState extends State<DoctorAdd> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      height: MediaQuery.of(context).size.height / 1.3,
      width: MediaQuery.of(context).size.width,
      borderRadius: 24,
      primaryColor: Theme.of(context).primaryColor,
      curvature: Curvature.flat,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 35,
            ),
            const SpecialLine(),
            const Spacer(
              flex: 2,
            ),
            const SizedBox(
              child: FontBoldHeader(
                  content: "Add Doctor Visit Reminder", contentSize: 18),
            ),
            const Spacer(
              flex: 1,
            ),
            InputField(
              heading: "Doctor Name",
              pass: widget.doctorName,
            ),
            const Spacer(
              flex: 1,
            ),
            InputField(
              heading: "Location",
              pass: widget.location,
            ),
            const Spacer(
              flex: 1,
            ),
            DateTimeSpecial(
              heading: widget.timeHeading,
              click: widget.date,
              date: true,
            ),
            const Spacer(
              flex: 2,
            ),
            ButtonSpecial(
              special: true,
              heading: "Set Reminder",
              click: widget.reminderButton,
            ),
            const Spacer(
              flex: 1,
            ),
            ButtonSpecial(
              heading: "Cancel",
              click: widget.cancelButton,
            ),
            const Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
