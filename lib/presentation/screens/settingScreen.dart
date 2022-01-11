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

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

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
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                    const SizedBox(
                      height: 20,
                    ),
                    const StaticButtonSpacial(heading: "About", content: ""),
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
                      click: () {},
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
