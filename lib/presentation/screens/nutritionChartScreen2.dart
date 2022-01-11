// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/fontLigntRed.dart';
import 'package:vigour/presentation/components/specialLine.dart';

class NutritionChartScreen2 extends StatelessWidget {
  const NutritionChartScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
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
                  width: 84,
                ),
                const FontBoldHeader(
                    content: "Nutrition Charts", contentSize: 18),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            NeumorphicContainer(
              width: 355,
              height: 690,
              borderRadius: 20,
              primaryColor: Theme.of(context).primaryColor,
              child: ListView(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const SpecialLine(),
                        const SizedBox(
                          height: 20,
                        ),
                        const FontLightHeader(
                          content:
                              "For the nutrients with DVs that are going down to Childrens",
                          contentSize: 24,
                          numberOfLines: 25,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 343,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/images/chart_eg.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const FontLight(
                          content:
                              "Good morning and happy first day of classes! Getting back into a school routine can be very challenging after experiencing an online platform during the pandemic. It is important to have a plan set in place so your on-campus experience can prosper. Going back to in-person classes can trigger anxiety and depression. It is recommended to set goals for yourself in order to have a healthy routine on campus. As an incoming Junior, I can’t wait to share all of these awesome tips and tricks to combat anxiety on the first week back to school!",
                          contentSize: 16,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const ReturnFooter(
                          autherName: "MC Anupama",
                          datePublished: "22/11/2021",
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReturnFooter extends StatelessWidget {
  final String autherName;
  final String datePublished;
  const ReturnFooter({required this.autherName, required this.datePublished});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const FontLightRed(content: "Author:", contentSize: 14),
            const SizedBox(
              width: 5,
            ),
            FontLight(
              content: autherName,
              contentSize: 14,
            ),
          ],
        ),
        Row(
          children: [
            const FontLightRed(content: "Published Date:", contentSize: 14),
            const SizedBox(
              width: 5,
            ),
            FontLight(
              content: datePublished,
              contentSize: 14,
            ),
          ],
        ),
      ],
    );
  }
}
