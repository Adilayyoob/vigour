// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/models/documentUploadAreaModel.dart';
import 'package:vigour/models/service/preference_service.dart';
import 'package:vigour/presentation/components/addButton.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:vigour/presentation/components/theMasterCard.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DocumentUploadArea extends StatefulWidget {
  DocumentUploadArea({Key? key}) : super(key: key);

  @override
  _DocumentUploadAreaState createState() => _DocumentUploadAreaState();
}

class _DocumentUploadAreaState extends State<DocumentUploadArea> {
  bool popDrawVis = false;
  String documentName = "";
  String imgURL = "";
  Map<int, dynamic> documentList = <int, dynamic>{};
  File? pickedImage;
  final _PreferencesService = PreferenceService();

  String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  Future<void> _upload() async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      final String fileName = path.basename(pickedImage.path);
      imgURL = fileName;
      File imageFile = File(pickedImage.path);
      setState(() => this.pickedImage = imageFile);
      
    } catch (err) {
      print(err);
    }
  }

  void saveDocument() {
    final newDocument = DocumentUploadAreaModel(id: 0,
        title: documentName, date: getCurrentDate(), imageURL: imgURL);
        _PreferencesService.saveDocument(newDocument);
  }

  void _populateFields() async {
    final document = await _PreferencesService.getDocument();
    documentList[0] = {
          "date": document.date,
          "title": document.title,
          "img_url": document.imageURL
        };
      print(documentList);
  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _populateFields();
  // }

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
                              content: "Document Upload Area", contentSize: 18),
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
                        // child: ListView.builder(
                        //   itemBuilder: (BuildContext context, int index) =>
                        child: ListView(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          children: [
                            TheMasterCard(
                              click: () {
                                _populateFields();
                              },
                              date: "Friday, 24/12/2021",
                              title: "Head Scan",
                              documentFileName: "IMG0002.JPEG",
                              reminderTime: "3:36 PM",
                              delete: () {},
                              visibleTime: false,
                            ),
                          ],
                        ),
                        //   itemCount: documentList.length,
                        // ),
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
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  borderRadius: 24,
                  primaryColor: Theme.of(context).primaryColor,
                  curvature: Curvature.flat,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        const SpecialLine(),
                        const Spacer(
                          flex: 2,
                        ),
                        const SizedBox(
                          width: 325,
                          child: FontBoldHeader(
                              content: "Add Document", contentSize: 18),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        InputField(
                          heading: "Document Name",
                          pass: (value) {
                            documentName = value;
                          },
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        ButtonSpecial(
                            special: true,
                            heading: "Upload Document",
                            click: () {
                              if (documentName.isEmpty) {
                                const snackBar = SnackBar(
                                  content: Text('Please Enter Document Name!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  popDrawVis = false;
                                });
                                _upload();
                                saveDocument();
                              }
                            }),
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
