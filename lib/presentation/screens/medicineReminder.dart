// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/database/vigourDB.dart';
import 'package:vigour/models/medicineReminderModel.dart';
import 'package:vigour/notification/notification_api.dart';
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
  String date = "";
  bool status = false;
  bool colourPillVis = true;
  Color getColor = const Color.fromRGBO(207, 111, 128, 1);
  Map<int, DateTime> times = {};
  String _dateToPass = "";

  bool isLoading = false;
  late List<medicineReminderModel> medicines;
  late medicineReminderModel medicine2;

  // DateTime date1 = DateTime.now();

  @override
  void initState() {
    super.initState();

    refreshMedicine();
    NotificationApi.init();
    listenNotifications();
  }

  Future refreshMedicine() async {
    setState(() => isLoading = true);

    this.medicines = await VigourDatabase.instance.readAllMedicine();

    setState(() => isLoading = false);
  }

  Future addMedicine() async {
    final medicine = medicineReminderModel(
        medicineName: medicineName,
        genericName: genericName,
        brandName: brandName,
        medicineType: medicineType,
        unit: unit,
        dose: dose,
        date: date,
        colour: getColor.toString(),
        status: status);

    await VigourDatabase.instance.createMedicine(medicine);
  }

  String formatTime(String t) {
    DateTime tempDate = DateTime.parse(t);
    String formattedTime = DateFormat.jm().format(tempDate);
    return formattedTime;
  }

  String formatDate(String t) {
    DateTime tempDate = DateTime.parse(t);
    String formattedDate = DateFormat('dd-MM-yyyy').format(tempDate);
    return formattedDate;
  }

  String convertHourMinute(DateTime t) {
    String formatTime = DateFormat('HH:mm').format(t).toString();
    return formatTime;
  }

  Color toColour(String c) {
    String valueString = c.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = new Color(value);
    return otherColor;
  }

  String unfoldMap(Map m) {
    String out = "";
    m.values.forEach((value) {
      out = out + "[" + formatTime(value.toString()) + "]" + " ";
    });
    return out;
  }

  void getNotified(String name, String qty, String unit, String date) {
    DateTime tempDate = DateTime.parse(date);
    print("fised date : $date");
    NotificationApi.showScheduleNotification(
      title: 'Medicine Reminder',
      body:
          'Its time to take $qty $unit of $name. (Click to record visit to report)',
      payload: date,
      scheduledDate: tempDate,
    );
  }

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
                            : medicines.isEmpty
                                ? const Center(
                                    child: FontLightRed(
                                        content: "No Medicine Reminder Found",
                                        contentSize: 14),
                                  )
                                : buildMedicine(),
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
                  primaryColor: Theme.of(context).primaryColor,
                  borderRadius: 24,
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
                        height: MediaQuery.of(context).size.height / 1.7,
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
                                                  "Selected Time: ${unfoldMap(times)}",
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
                            const SizedBox(
                              height: 20,
                            ),
                            ButtonSpecial(
                              special: true,
                              heading: "Set Reminder",
                              click: () {
                                if ((medicineName.isEmpty) || (dose.isEmpty)) {
                                  const snackBar = SnackBar(
                                    content: Text(
                                        "Enter atleast 'Medicine Name','Dose'"),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  for (int j = 0; j < int.parse(forDay); j++) {
                                    if (j == 0) {
                                      // date1 = DateTime.now();
                                      // date = date1.toString();
                                      _dateToPass = DateTime.now().toString();
                                      _dateToPass = _dateToPass.replaceRange(
                                          17, 26, "00.000000");
                                      print(_dateToPass);
                                    } else {
                                      // DateTime date2 = date1.add(const Duration(
                                      //   days: 1,
                                      // ));
                                      // date = date2.toString();
                                      DateTime _dateToPass2 =
                                          DateTime.parse(_dateToPass);
                                      _dateToPass = _dateToPass2
                                          .add(const Duration(days: 1))
                                          .toString();
                                      print(_dateToPass);
                                    }
                                    for (int i = 0;
                                        i < int.parse(timesADay);
                                        i++) {
                                      _dateToPass = _dateToPass.replaceRange(
                                          11, 16, convertHourMinute(times[i]!));

                                      date = _dateToPass;
                                      print(_dateToPass);
                                      addMedicine();
                                      getNotified(
                                          medicineName, dose, unit, date);
                                    }
                                  }
                                  refreshMedicine();
                                  setState(() {
                                    popDrawVis = false;
                                  });
                                  times.clear();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
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
                            heading: "Cancel",
                            click: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {
                                popDrawVis = false;
                              });
                            }),
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
                times[index] = value;
                setState(() {});
                print(times);
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      });

  Widget buildMedicine() => ListView.builder(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          final medicine = medicines[index];

          if (medicine.medicineType != "Pill") {
            return TheMasterCard(
              click: () {},
              date: formatDate(medicine.date),
              title: medicine.medicineName,
              documentFileName:
                  "${medicine.medicineType} ${medicine.dose} ${medicine.unit}",
              delete: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title:
                      const FontBoldHeader(content: "Delete", contentSize: 18),
                  content: FontLightRed(
                      content:
                          "Do you want to delete the reminder of ${medicine.medicineName} medicine at ${formatDate(medicine.date)} [${formatTime(medicine.date)}]?",
                      contentSize: 14),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await VigourDatabase.instance
                            .deleteMedicine(medicine.id!);

                        Navigator.pop(context, 'OK');
                        refreshMedicine();
                        setState(() {});
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              visibleTime: true,
              reminderTime: formatTime(medicine.date),
            );
          } else {
            return TheMasterCard(
              masterCardColour: true,
              colourPill: toColour(medicine.colour),
              click: () {},
              date: formatDate(medicine.date),
              title: medicine.medicineName,
              documentFileName:
                  "${medicine.medicineType} ${medicine.dose} ${medicine.unit}",
              delete: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title:
                      const FontBoldHeader(content: "Delete", contentSize: 18),
                  content: FontLightRed(
                      content:
                          "Do you want to delete the reminder of ${medicine.medicineName} medicine at ${formatDate(medicine.date)} [${formatTime(medicine.date)}]?",
                      contentSize: 14),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await VigourDatabase.instance
                            .deleteMedicine(medicine.id!);

                        Navigator.pop(context, 'OK');
                        refreshMedicine();
                        setState(() {});
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              visibleTime: true,
              reminderTime: formatTime(medicine.date),
            );
          }
        },
      );
  Future notificationSelected(String? payload) async {
    for (int i = 0; i < medicines.length; i++) {
      if (medicines[i].date == payload) {
        medicine2 = medicines[i];
        final med = medicineReminderModel(
            id: medicine2.id,
            medicineName: medicine2.medicineName,
            genericName: medicine2.genericName,
            brandName: medicine2.brandName,
            medicineType: medicine2.medicineType,
            unit: medicine2.unit,
            dose: medicine2.dose,
            date: medicine2.date,
            colour: medicine2.colour,
            status: true);
        print(payload);
        await VigourDatabase.instance.updateMedicine(med);
      }
    }
  }
}
