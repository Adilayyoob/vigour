// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:vigour/presentation/components/staticButtonSpacial.dart';
import 'package:vigour/presentation/components/switchButton.dart';
import 'package:vigour/presentation/components/userImageAdd.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
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
                      width: 100,
                    ),
                    const FontBoldHeader(content: "Settings", contentSize: 18),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  width: 170,
                  height: 170,
                  child: UserImageAdd(),
                ),
                const SizedBox(
                  height: 20,
                ),
                const FontBoldHeader(content: "Sara_Yacub", contentSize: 28),
              ],
            ),
            Positioned(
              bottom: 0,
              child: NeumorphicContainer(
                height: 490,
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
                    const SwitchButton(content: "Notification"),
                    const SizedBox(
                      height: 20,
                    ),
                    const StaticButtonSpacial(
                        heading: "Help",
                        content:
                            "Vigour-your health companion is a health care related mobile application that helps people to take care of their heath.It provides services such as medicine and doctor visit reminder,drink water reminder BMI calculator, nutrition chat and yoga tips."),
                    const SizedBox(
                      height: 20,
                    ),
                    const StaticButtonSpacial(
                        heading: "About",
                        content:
                            "The application is made as project work by the Farook college 3rd year Bsc CS students.This app is developed in flutter for both Android and iOS platform.\n\nDeveloper details\n\nAdil Ayyoob\n+91 81292 65497\nadilkuyyo@gmail.com\n\nRaniya Jubin\n+91 90487 71119\njubinraniya@gmail.com\n\nRishana Akbar Ali\n+91 90618 00875\nrish86060@gmail.com\n\nThoufiq\n+91 70349 80196\nthoufiqpk9@gmail.com\n\nHari Krishnan T\n+91 83010 33521\nhk5115178@gmail.com"),
                    const SizedBox(
                      height: 20,
                    ),
                    const StaticButtonSpacial(
                        heading: "Invite A Friend", content: ""),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonSpecial(
                      heading: "Logout",
                      click: () {
                        _auth.signOut();
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ >= 2);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
