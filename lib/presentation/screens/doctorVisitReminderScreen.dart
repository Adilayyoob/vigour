// ignore_for_file: file_names

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/database/vigourDB.dart';
import 'package:vigour/models/doctorVisitReminderModel.dart';
import 'package:vigour/presentation/components/addButton.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntRed.dart';
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
  bool popDrawVis = false;
  bool isLoading = false;
  late List<DoctorVisitReminderModel> doctors;
  String doctorName = "";
  String location = "";
  String date = "";
  String time = "";
  bool status = false;

  // String doctorNameini ="";
  // String locationini = "";

  @override
  void initState() {
    super.initState();

    refreshDoctor();
  }

  Future refreshDoctor() async {
    setState(() => isLoading = true);

    this.doctors = await VigourDatabase.instance.readAllDoctor();

    setState(() => isLoading = false);
  }

  Future addDoctor() async {
    final doctor = DoctorVisitReminderModel(
        name: doctorName,
        date: date,
        time: time,
        location: location,
        status: status);

    await VigourDatabase.instance.createDoctor(doctor);
  }

  String convertToDate(String ts) {
    // DateTime tsdate = ts as DateTime;
    DateTime tsdate = DateFormat("yyyy-MM-dd").parse(ts);
    String fdatetime = DateFormat('dd-MM-yyy').format(
        tsdate); //DateFormat() is from intl package //output: 04-Dec-2021
    return fdatetime;
  }

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
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          BackButtonNeo(),
                          const Spacer(
                            flex: 3,
                          ),
                          const FontBoldHeader(
                              content: "Doctor Visit Reminder",
                              contentSize: 18),
                          const Spacer(
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
                            ? const Center(
                                child: FontLight(
                                content: "Loading...",
                                contentSize: 14,
                              ))
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
                      // doctorNameini = "";
                      // locationini = "";
                      popDrawVis = true;
                    });
                  },
                )),
            Visibility(
              visible: popDrawVis,
              child: Positioned(
                bottom: 0,
                child: DoctorAdd(
                  doctorName: (value) {
                    doctorName = value;
                    print(value);
                  },
                  location: (value) {
                    location = value;
                  },
                  date: (value) {
                    date = convertToDate(value.substring(0, 10));
                    time = value.substring(11, 16);
                  },
                  reminderButton: () {
                    if ((doctorName.isEmpty) || (date.isEmpty)) {
                      const snackBar = SnackBar(
                        content: Text(
                            "Enter atleast 'Doctor Name' and 'Date & Time'"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      addDoctor();
                      refreshDoctor();
                      setState(() {
                        popDrawVis = false;
                      });
                    }
                  },
                  cancelButton: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      popDrawVis = false;
                    });
                  },
                  // doctorNameini: doctorNameini,
                  // locationini: locationini,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDoctor() => ListView.builder(
        padding: const EdgeInsets.only(left: 20, right: 20),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return TheMasterCard(
            click: () {
              setState(() {
                // doctorNameini = doctor.name;
                // locationini = doctor.location;
                // popDrawVis = true;
              });
            },
            date: doctor.date,
            title: doctor.name,
            documentFileName: doctor.location,
            delete: () => showDialog<String>(
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
            reminderTime: doctor.time,
          );
        },
      );
}

class DoctorAdd extends StatefulWidget {
  final Function(String) doctorName;
  final Function(String) location;
  final Function(String) date;
  final VoidCallback reminderButton;
  final VoidCallback cancelButton;
  final String doctorNameini;
  final String locationini;

  DoctorAdd({
    required this.doctorName,
    required this.location,
    required this.date,
    required this.reminderButton,
    required this.cancelButton,
    this.doctorNameini = "",
    this.locationini = "",
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
              // initialText: widget.doctorNameini,
            ),
            const Spacer(
              flex: 1,
            ),
            InputField(
              heading: "Location",
              pass: widget.location,
              // initialText: widget.locationini,
            ),
            const Spacer(
              flex: 1,
            ),
            DateTimePicker(
              type: DateTimePickerType.dateTime,
              dateMask: 'dd-MM-yyyy h:m a',
              // initialValue: DateTime.now().toString(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: const Icon(Icons.event),
              dateLabelText: 'Date & Time',
              locale: const Locale('en', 'US'),
              onChanged: widget.date,
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
