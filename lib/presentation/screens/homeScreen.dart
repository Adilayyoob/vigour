// ignore_for_file: file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/appName.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/homeContainerButton.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppName(),
                    const SizedBox(
                      width: 195,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/SettingScreen');
                      },
                      child: NeumorphicContainer(
                        width: 52,
                        height: 52,
                        borderRadius: 30,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            "assets/images/unknown_person.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 214,
                  width: 300,
                  child: SvgPicture.asset("assets/images/home_image.svg"),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              child: NeumorphicContainer(
                height: 540,
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
                      width: 320,
                      child: FontBoldHeader(content: "Home", contentSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 440,
                      child: GridView.count(
                        padding: const EdgeInsets.only(left: 35,right: 35,top: 10),
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        crossAxisCount: 2,
                        scrollDirection: Axis.vertical,
                        children: [
                          HomeContainerButton(
                            content: "Medicine Reminder",
                            iconName: FontAwesomeIcons.capsules,
                            click: () {},
                          ),
                          HomeContainerButton(
                            content: "Doctor Visit Reminder",
                            iconName: FontAwesomeIcons.hospitalUser,
                            click: () {},
                          ),
                          HomeContainerButton(
                            content: "Drink Water Reminder",
                            iconName: FontAwesomeIcons.glassWhiskey,
                            click: () {},
                          ),
                          HomeContainerButton(
                            content: "BMI Calculator",
                            iconName: FontAwesomeIcons.calculator,
                            click: () {
                              Navigator.pushNamed(
                                  context, '/BMICalculatorScreen');
                            },
                          ),
                          HomeContainerButton(
                            content: "Document Upload Area",
                            iconName: Icons.account_balance_wallet,
                            click: () {
                              Navigator.pushNamed(
                                  context, '/DocumentUploadArea');
                            },
                          ),
                          HomeContainerButton(
                            content: "Nutrition Charts",
                            iconName: FontAwesomeIcons.nutritionix,
                            click: () {
                              Navigator.pushNamed(
                                  context, '/NutritionChartScreen');
                            },
                          ),
                          HomeContainerButton(
                            content: "Home Medicine Library",
                            iconName: FontAwesomeIcons.bookMedical,
                            click: () {},
                          ),
                          HomeContainerButton(
                            content: "Exercise And Yoga Tips",
                            iconName: Icons.self_improvement,
                            click: () {},
                          ),
                          HomeContainerButton(
                            content: "Community Chat",
                            iconName: Icons.question_answer,
                            click: () {
                              Navigator.pushNamed(
                                  context, '/CommunityChatScreen');
                            },
                          ),
                          HomeContainerButton(
                            content: "Report",
                            iconName: Icons.assessment,
                            click: () {},
                          ),
                        ],
                      ),
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
