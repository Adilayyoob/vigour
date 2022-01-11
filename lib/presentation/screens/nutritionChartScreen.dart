// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/theMainCard.dart';

class NutritionChartScreen extends StatelessWidget {
  const NutritionChartScreen({Key? key}) : super(key: key);
  

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
            SizedBox(
              height: 700,
              width: 350,
              child: ListView(
                padding: const EdgeInsets.only(top: 0),
                children: const [
                  TheMainCard(
                      heading: "For the nutrients with DVs that are going down",
                      author: "MC Anupama",
                      imageUrl: "assets/images/chart_eg.jpg"),
                  TheMainCard(
                      heading: "For the nutrients with DVs that are going down",
                      author: "MC Anupama",
                      imageUrl: "assets/images/chart_eg.jpg"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
