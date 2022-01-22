// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/database/vigourDB.dart';
import 'package:vigour/models/documentUploadAreaModel.dart';
import 'package:vigour/models/service/preference_service.dart';
import 'package:vigour/models/userData.dart';
import 'package:vigour/presentation/components/addButton.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/fontLigntRed.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:vigour/presentation/components/theMasterCard.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:vigour/presentation/screens/documentUploadAreaView.dart';

class DocumentUploadArea extends StatefulWidget {
  DocumentUploadArea({Key? key}) : super(key: key);

  @override
  _DocumentUploadAreaState createState() => _DocumentUploadAreaState();
}

class _DocumentUploadAreaState extends State<DocumentUploadArea> {
  bool popDrawVis = false;

  bool isLoading = false;
  late List<DocumentUploadAreaModel> documents;
  String documentName = "";
  String imgURL = "";
  String username = "";

  File? pickedImage;
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();

    refreshDocument();
  }

  // @override
  // void dispose() {
  //   VigourDatabase.instance.close();

  //   super.dispose();
  // }

  Future refreshDocument() async {
    setState(() => isLoading = true);

    this.documents = await VigourDatabase.instance.readAllDocument();

    setState(() => isLoading = false);
  }

  // final _PreferencesService = PreferenceService();

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
      File imageFile = File(pickedImage.path);
      setState(() => this.pickedImage = imageFile);
      imgURL = documentName.replaceAll(" ", "_") + ".jpg";
      try {
        // Uploading the selected image with some custom meta data
        await storage.ref("document/$username/$imgURL").putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': '$username',
              'document_name': '$imgURL'
            }));

        // Refresh the UI
        FocusScope.of(context).requestFocus(FocusNode());
        Future addNote() async {
          final document = DocumentUploadAreaModel(
              title: documentName, date: getCurrentDate(), imgURL: imgURL);

          await VigourDatabase.instance.create(document);
        }

        addNote();
        refreshDocument();
        setState(() {
          popDrawVis = false;
        });
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          final snackBar = SnackBar(
          content: Text(error.toString()),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
        final snackBar = SnackBar(
          content: Text(err.toString()),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserData;
    username = args.UserName;
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
                        child: isLoading
                            ? const Center(
                                child: FontLight(
                                content: "Loading...",
                                contentSize: 14,
                              ))
                            : documents.isEmpty
                                ? const Center(
                                    child: FontLightRed(
                                        content: "No Documents Uploaded",
                                        contentSize: 14),
                                  )
                                : buildDocument(),
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
                                _upload(); //picker

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

  Widget buildDocument() => ListView.builder(
        padding: EdgeInsets.only(left: 20, right: 20),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final document = documents[index];

          return TheMasterCard(
            click: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DocumentUploadAreaView(
                  docImage: document.imgURL,
                  username: username,
                ),
              ));

              refreshDocument();
            },
            date: document.date,
            title: document.title,
            documentFileName: document.imgURL,
            delete: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const FontBoldHeader(content: "Delete", contentSize: 18),
                content: FontLightRed(
                    content:
                        "Do you want to delete the document ${document.title}?",
                    contentSize: 14),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await VigourDatabase.instance.delete(document.id!);

                      Navigator.pop(context, 'OK');
                      refreshDocument();
                      setState(() {});
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            visibleTime: false,
          );
        },
      );
}

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
