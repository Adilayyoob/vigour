// ignore_for_file: file_names

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/addButton.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/dropDownSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:vigour/presentation/components/theMasterCard.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MedicineReminderScreen extends StatefulWidget {
  MedicineReminderScreen({Key? key}) : super(key: key);

  @override
  _MedicineReminderScreenState createState() => _MedicineReminderScreenState();
}

class _MedicineReminderScreenState extends State<MedicineReminderScreen> {
  bool popDrawVis = false;
  String medicineType = "Pill";
  String unit = "Count";
  int timesADay = 1;
  Map<int, dynamic> MedicineReminderList = <int, dynamic>{};

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
                              content: "Medicine Reminder", contentSize: 18),
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
                          itemCount: MedicineReminderList.length,
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
                child: Container(
                  height: MediaQuery.of(context).size.height / 1,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      const Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: SpecialLine()),
                      const Spacer(
                        flex: 2,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: ListView(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          children: [
                            const FontBoldHeader(
                                content: "Add Medicine Reminder",
                                contentSize: 18),
                            const SizedBox(
                              height: 30,
                            ),
                            InputField(
                              heading: "Medicine Name",
                              pass: (value) {},
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DropDownSpecial(
                              heading: "Medicine Type",
                              click: (String? newValue) {
                                setState(() {
                                  medicineType = newValue!;
                                });
                              },
                              selected: medicineType,
                              items: const [
                                "Pill",
                                "Solution",
                                "Injection",
                                "Powder",
                                "Drops",
                                "Inhaler",
                                "Other"
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DropDownSpecial(
                              heading: "Unit",
                              click: (String? newValue) {
                                setState(() {
                                  unit = newValue!;
                                });
                              },
                              selected: unit,
                              items: const [
                                "Count",
                                "ml",
                                "mcg",
                                "g",
                                "mg",
                                "Drops",
                                "Puff",
                                "Other"
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputField(
                              heading: "Dose",
                              pass: (value) {},
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputField(
                              heading: "How Many Times A Day?",
                              pass: (value) {},
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputField(
                              heading: "For How Many Days?",
                              pass: (value) {},
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 64.0 * timesADay,
                                child: buildTimes()),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    iconSize: 100,
                                    onPressed: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Choose colour'),
                                        content: SingleChildScrollView(
                                          child: ColorPicker(
                                            pickerColor:
                                                Colors.red, //default color
                                            onColorChanged: (Color color) {
                                              //on color picked
                                              print(color);
                                            },
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    icon: Icon(
                                      FontAwesomeIcons.capsules,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const FontLightHeader(
                                    content:
                                        "Click on the icon to add colour to pill",
                                    contentSize: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: ButtonSpecial(
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
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: ButtonSpecial(
                            heading: "Cancel",
                            click: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {
                                popDrawVis = false;
                              });
                            }),
                      ),
                      const Spacer(
                        flex: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimes() => ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      itemCount: timesADay,
      itemBuilder: (context, index) {
        // final doctor = doctors[index];

        return DateTimePicker(
          type: DateTimePickerType.time,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          icon: Icon(Icons.event),
          dateLabelText: 'Date',
          timeLabelText: "Time",
          use24HourFormat: false,
        );
      });
}
