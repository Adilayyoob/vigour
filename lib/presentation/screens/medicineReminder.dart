// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/addButton.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/dateTimeSpecial.dart';
import 'package:vigour/presentation/components/dropDownSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/fontLigntRed.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:vigour/presentation/components/theMasterCard.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class MedicineReminderScreen extends StatefulWidget {
  MedicineReminderScreen({Key? key}) : super(key: key);

  @override
  _MedicineReminderScreenState createState() => _MedicineReminderScreenState();
}

class _MedicineReminderScreenState extends State<MedicineReminderScreen> {
  bool popDrawVis = false;
  String medicineName = "";
  String genericName = "";
  String brandName = "";
  String medicineType = "Pill";
  String unit = "Count";
  String dose = "0";
  String timesADay = "1";
  String forDay = "1";
  bool colourPillVis = true;

  // List<String> time = [];

  Map<int, String> time = {};

  Color getColor = const Color.fromRGBO(207, 111, 128, 1);

  Map<int, dynamic> MedicineReminderList = <int, dynamic>{};

  String formatTime(String t) {
    DateTime tempDate = DateFormat("kk:mm").parse(t);
    String formattedTime = DateFormat('hh:mm a').format(tempDate);
    return formattedTime;
  }

  String formatTime24(DateTime t) {
    String formattedTime = DateFormat('kk:mm').format(t);
    return formattedTime;
  }

  String unfoldMap(Map m) {
    String out = "";
    m.values.forEach((value) {
      out = out + "[" + formatTime(value) + "]" + " ";
    });
    return out;
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
                        child: Column(
                          children: [
                            TheMasterCard(
                              click: () {},
                              date: "20/12/12",
                              title: "title dsvdvdsjhkj",
                              documentFileName: "sadSCCSakjkjjkj",
                              reminderTime: "03:36 PM",
                              delete: () {},
                              visibleTime: true,
                              masterCardColour: false,
                            ),
                            
                          ],
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
                              pass: (value) {
                                medicineName = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputField(
                              heading: "Generic Name (Optional)",
                              pass: (value) {
                                genericName = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputField(
                              heading: "Brand Name (Optional)",
                              pass: (value) {
                                brandName = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DropDownSpecial(
                              heading: "Medicine Type",
                              click: (String? newValue) {
                                setState(() {
                                  medicineType = newValue!;
                                  if (medicineType == "Pill") {
                                    colourPillVis = true;
                                  } else {
                                    colourPillVis = false;
                                  }
                                  print(medicineType);
                                  print(colourPillVis);
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
                              keyboard: TextInputType.number,
                              heading: "Dose",
                              pass: (value) {
                                dose = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputField(
                              keyboard: TextInputType.number,
                              heading: "How Many Times A Day?",
                              pass: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    timesADay = "1";
                                  });
                                } else {
                                  setState(() {
                                    timesADay = value;
                                  });
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputField(
                              keyboard: TextInputType.number,
                              heading: "For How Many Days?",
                              pass: (value) {
                                forDay = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            NeumorphicContainer(
                              height: 58,
                              borderRadius: 20,
                              primaryColor: Theme.of(context).primaryColorDark,
                              curvature: Curvature.flat,
                              spread: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Spacer(
                                    flex: 2,
                                  ),
                                  Expanded(
                                    flex: 28,
                                    child: SizedBox(
                                      height: 21,
                                      width: 180,
                                      child: ListView(
                                        primary: false,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          FontLightHeader(
                                              content:
                                                  "Selected Time: ${unfoldMap(time)}",
                                              contentSize: 18,
                                              colour: Colors.white),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 2,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 80.0 * int.parse(timesADay),
                                child: buildTimes()),
                            const SizedBox(
                              height: 20,
                            ),
                            Visibility(
                              visible: colourPillVis,
                              child: SizedBox(
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
                                              pickerColor: const Color.fromRGBO(
                                                  207,
                                                  111,
                                                  128,
                                                  1), //default color
                                              onColorChanged: (Color color) {
                                                setState(() {
                                                  getColor = color;
                                                });
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
                                        color: getColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const FontLightHeader(
                                      content:
                                          "Click on the icon to add colour to Pill (Optional)",
                                      contentSize: 16,
                                    ),
                                  ],
                                ),
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
      primary: false,
      padding: const EdgeInsets.only(top: 0),
      itemCount: int.parse(timesADay),
      itemBuilder: (context, index) {
        // final doctor = doctors[index];

        return Column(
          children: [
            DateTimeSpecial(
              heading: "Pick Time ${index + 1}",
              click: (value) {
                time[index] = formatTime24(value);
                setState(() {});
                print(time);
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      });
}
