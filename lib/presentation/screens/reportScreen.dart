// ignore_for_file: file_names, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/database/vigourDB.dart';
import 'package:vigour/models/doctorVisitReminderModel.dart';
import 'package:vigour/models/medicineReminderModel.dart';
import 'package:vigour/models/userData.dart';
import 'package:vigour/notification/notification_api.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/fontLigntRed.dart';
import 'package:vigour/presentation/components/reportCard.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:vigour/pdf_api/pdf_api.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool isLoading = false;
  late List<medicineReminderModel> medicines;
  late List<DoctorVisitReminderModel> doctors;

  @override
  void initState() {
    super.initState();
    refreshMedicine();
  }

  Future refreshMedicine() async {
    setState(() => isLoading = true);

    this.medicines = await VigourDatabase.instance.readAllMedicine();
    this.doctors = await VigourDatabase.instance.readAllDoctor();
    setState(() => isLoading = false);
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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserData;
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(
              height: 35,
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
                const FontBoldHeader(content: "Report", contentSize: 18),
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
              child: ListView(
                padding: EdgeInsets.only(left: 20, right: 20),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      FontLight(content: "Medicine Reminder", contentSize: 14),
                      const SizedBox(
                        height: 10,
                      ),
                      NeumorphicContainer(
                        height: 500,
                        borderRadius: 20,
                        primaryColor: Theme.of(context).primaryColor,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
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
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const FontLight(
                          content: "Doctor Visit Reminder", contentSize: 14),
                      const SizedBox(
                        height: 10,
                      ),
                      NeumorphicContainer(
                          height: 500,
                          borderRadius: 20,
                          primaryColor: Theme.of(context).primaryColor,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: isLoading
                                ? Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                  )
                                : doctors.isEmpty
                                    ? const Center(
                                        child: FontLightRed(
                                            content: "No Doctor visit Found",
                                            contentSize: 14),
                                      )
                                    : buildDoctor(),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonSpecial(
                      heading: "Generate PDF",
                      click: () async {
                        final pdf = await PdfApi.generateCenteredText("${args.UserName}",medicines,doctors);
                        PdfApi.openFile(pdf);
                      }
                      ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMedicine() => ListView.builder(
        primary: false,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          final medicine = medicines[index];

          return ReportCard(
            title: medicine.medicineName,
            time: "${formatDate(medicine.date)} [${formatTime(medicine.date)}]",
            status: medicine.status,
          );
        },
      );

  Widget buildDoctor() => ListView.builder(
        primary: false,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return ReportCard(
            title: doctor.name,
            time: "${formatDate(doctor.date)} [${formatTime(doctor.date)}]",
            status: doctor.status,
          );
        },
      );
}
