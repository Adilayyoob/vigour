// ignore_for_file: file_names

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/addButton.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
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
  Map<int, dynamic> doctorVisitList = <int, dynamic>{};
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
                        child: ListView.builder(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          itemBuilder: (BuildContext context, int index) =>
                              TheMasterCard(
                            click: () {},
                            date: "20/12/12",
                            title: "title",
                            documentFileName: "",
                            reminderTime: "3:36 PM",
                            delete: () {},
                            visibleTime: true,
                          ),
                          // ],
                          // ),
                          itemCount: doctorVisitList.length,
                        ),
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
                child: NeumorphicContainer(
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
                              content: "Add Doctor Visit Reminder",
                              contentSize: 18),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        InputField(
                          heading: "Doctor Name",
                          pass: (value) {},
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        InputField(
                          heading: "Location",
                          pass: (value) {},
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        DateTimePicker(
                          type: DateTimePickerType.dateTimeSeparate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          icon: Icon(Icons.event),
                          dateLabelText: 'Date',
                          timeLabelText: "Time",
                          use24HourFormat: false,
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        ButtonSpecial(
                          special: true,
                          heading: "Set Reminder",
                          click: () {
                            // if (documentName.isEmpty) {
                            //   const snackBar = SnackBar(
                            //     content: Text('Please Enter Document Name!'),
                            //   );
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(snackBar);
                            // } else {
                            //   //  _upload();//picker
                            //   FocusScope.of(context).requestFocus(FocusNode());
                            //   _id++;
                            //   documentList[_id] = {
                            //     "date": getCurrentDate(),
                            //     "title": documentName,
                            //     "img_url": imgURL
                            //   };
                            //   print(documentList);
                            //   setState(() {
                            //     popDrawVis = false;
                            //   });

                            //   // saveDocument(_id+1);
                            //   // _populateFields();
                            // }
                          },
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        ButtonSpecial(
                            heading: "Cancel",
                            click: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {
                                popDrawVis = false;
                              });
                            }),
                        const Spacer(
                          flex: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
