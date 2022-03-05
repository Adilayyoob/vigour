import 'dart:io';

import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:vigour/models/doctorVisitReminderModel.dart';
import 'package:vigour/models/medicineReminderModel.dart';

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

class User {
  final String name;
  final int age;

  const User({required this.name, required this.age});
}

class PdfApi {
  static Future<File> generateCenteredText(
      String text,
      List<medicineReminderModel> medicines,
      List<DoctorVisitReminderModel> doctors) async {
    DateTime dt = DateTime.now();
    final medicineHeaders = [
      'ID',
      'Medicine Name',
      'Generic Name',
      'Brand Name',
      'MedicineType',
      'Dose & Unit',
      'Date & Time',
      'Status'
    ];
    final doctorHeaders = [
      'ID',
      'Doctor Name',
      'Location',
      'Date & Time',
      'Status'
    ];
    final data1 = medicines
        .map((medicineField) => [
              medicineField.id,
              medicineField.medicineName,
              medicineField.genericName,
              medicineField.brandName,
              medicineField.medicineType,
              '${medicineField.dose} ${medicineField.unit}',
              '${formatDate(medicineField.date)} ${formatTime(medicineField.date)}',
              medicineField.status? 'Taken' : 'Not taken'
            ])
        .toList();

     final data2 = doctors
        .map((doctorField) => [
              doctorField.id,
              doctorField.name,
              doctorField.location,
              '${formatDate(doctorField.date)} ${formatTime(doctorField.date)}',
              doctorField.status? 'Visited' : 'Not Visited'
            ])
        .toList();

    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => <Widget>[
        buildCustomHeader(),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        Paragraph(
          text: 'User: $text',
          style: TextStyle(fontSize: 14),
        ),
        Paragraph(
          text: 'Date & Time: ${formatDate(dt.toString())} ${formatTime(dt.toString())}',
          style: TextStyle(fontSize: 14),
        ),
        buildCustomHeadline('Medicine Reminder Report'),
        Table.fromTextArray(
          headers: medicineHeaders,
          data: data1,
          headerStyle: const TextStyle(
            fontSize: 8,
          ),
          cellStyle: const TextStyle(
            fontSize: 8,
          ),
        ),
        buildCustomHeadline('Doctor Visit Reminder Report'),
        Table.fromTextArray(
          headers: doctorHeaders,
          data: data2,
        ),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        Center(
          child: Paragraph(
            textAlign: TextAlign.center,
            text: 'Generated by Vigour',
            style: const TextStyle(
              fontSize: 12,
              color: PdfColors.red,
            ),
          ),
        ),
      ],
      footer: (context) {
        final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

        return Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
          child: Text(
            text,
            style: TextStyle(color: PdfColors.black),
          ),
        );
      },
    ));

    return saveDocument(name: 'my_report.pdf', pdf: pdf);
  }

  static Widget buildCustomHeader() => Container(
        padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
        ),
        child: Row(
          children: [
            PdfLogo(),
            SizedBox(width: 0.5 * PdfPageFormat.cm),
            Text(
              'PDF Report',
              style: TextStyle(fontSize: 20, color: PdfColors.blue),
            ),
          ],
        ),
      );

  static Widget buildCustomHeadline(String text) => Header(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(color: PdfColors.blue),
      );

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}