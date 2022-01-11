// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/addButton.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:vigour/presentation/components/theMasterCard.dart';

class DocumentUploadArea extends StatefulWidget {
  DocumentUploadArea({Key? key}) : super(key: key);

  @override
  _DocumentUploadAreaState createState() => _DocumentUploadAreaState();
}

class _DocumentUploadAreaState extends State<DocumentUploadArea> {
  bool popDrawVis = false;
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
                padding: const EdgeInsets.only(top: 0),
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          BackButtonNeo(),
                          const SizedBox(
                            width: 40,
                          ),
                          const FontBoldHeader(
                              content: "Document Upload Area", contentSize: 18),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 150,
                        child: ListView(
                          padding: const EdgeInsets.only(
                              top: 0, left: 20, right: 20),
                          children: const [
                            TheMasterCard(),
                            TheMasterCard(),
                            TheMasterCard(),
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
                child: NeumorphicContainer(
                  height: 370,
                  width: MediaQuery.of(context).size.width,
                  borderRadius: 24,
                  primaryColor: Theme.of(context).primaryColor,
                  curvature: Curvature.flat,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      const SpecialLine(),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: 325,
                        child: FontBoldHeader(
                            content: "Add Document", contentSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        heading: "Document Name",
                        pass: (value) {},
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ButtonSpecial(
                        special: true,
                          heading: "Upload Document",
                          click: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              popDrawVis = false;
                            });
                          }),
                           const SizedBox(
                        height: 20,
                      ),
                      ButtonSpecial(
                          heading: "Cancel",
                          click: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              popDrawVis = false;
                            });
                          })
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
}
