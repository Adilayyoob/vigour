// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable, avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'dart:math';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({Key? key}) : super(key: key);

  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  var BMI_Colors = <String, Color?>{
    "under weight": Colors.yellow,
    "Normal weight": Colors.green,
    "Over weight": Colors.orange,
    "Obese Class I": Colors.red,
    "Obese Class II": Colors.red[600],
    "Obese Class III": Colors.red[900]
  };
  String height = "0";
  String weight = "0";
  String result = "0";
  bool visib = false;
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
                      width: 84,
                    ),
                    const FontBoldHeader(
                        content: "BMI Calculator", contentSize: 18),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: visib,
                  child: Icon(
                    Icons.accessibility_rounded,
                    color: BMI_Colors["$result"],
                    size: 150,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: visib,
                  child: FontLightHeader(
                      content: result.toUpperCase(), contentSize: 36),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: NeumorphicContainer(
                height: 450,
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
                      height: 50,
                    ),
                    const SizedBox(
                      width: 325,
                      child: FontBoldHeader(
                          content: "Enter Details", contentSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputField(
                      heading: "Height (cm)",
                      pass: (value) {
                        height = value;
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    InputField(
                      heading: "Weight (kg)",
                      pass: (value) {
                        weight = value;
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ButtonSpecial(
                        heading: "Calculate BMI",
                        click: () {
                          BMICalculation b = BMICalculation(
                              height_1: height, weight_1: weight);
                          setState(() {
                            b.calculateBMI();
                            result = b.getStatus();
                            visib = true;
                            FocusScope.of(context).requestFocus(FocusNode());
                          });
                        }),
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

class BMICalculation {
  final String height_1;
  final String weight_1;
  double _bmi = 0;

  BMICalculation({this.height_1 = "0", this.weight_1 = "0"});

  String calculateBMI() {
    _bmi = int.parse(weight_1) / pow((int.parse(height_1)) / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getStatus() {
    if (_bmi > 40) {
      return "Obese Class III";
    } else if (_bmi > 35) {
      return "Obese Class II";
    } else if (_bmi > 30) {
      return "Obese Class I";
    } else if (_bmi > 25) {
      return "Over weight";
    } else if (_bmi > 18.5) {
      return "Normal weight";
    } else {
      return "under weight";
    }
  }
}
