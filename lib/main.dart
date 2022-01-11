// @dart=2.9
// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:vigour/presentation/screens/BMICalculatorScreen.dart';
import 'package:vigour/presentation/screens/communityChatScreen.dart';
import 'package:vigour/presentation/screens/documentUploadArea.dart';
import 'package:vigour/presentation/screens/documentUploadAreaView.dart';
import 'package:vigour/presentation/screens/homeScreen.dart';
import 'package:vigour/presentation/screens/loginScreen.dart';
import 'package:vigour/presentation/screens/nutritionChartScreen.dart';
import 'package:vigour/presentation/screens/nutritionChartScreen2.dart';
import 'package:vigour/presentation/screens/settingScreen.dart';
import 'package:vigour/presentation/screens/signupScreen.dart';
import 'package:vigour/presentation/screens/welcomeScreen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/HomeScreen",
    routes: <String, WidgetBuilder>{
      '/SignupScreen': (BuildContext context) => const SignUpScreen(),
      '/HomeScreen': (BuildContext context) => const HomeScreen(),
      '/SettingScreen': (BuildContext context) => const SettingScreen(),
      '/BMICalculatorScreen': (BuildContext context) => const BMICalculatorScreen(),
      '/DocumentUploadArea': (BuildContext context) => DocumentUploadArea(),
      '/NutritionChartScreen': (BuildContext context) => const NutritionChartScreen(),
      '/CommunityChatScreen': (BuildContext context) => CommunityChatScreen(),
      
     
    },
    title: 'Vigour',
    theme: ThemeData(
      primaryColor: const Color.fromRGBO(228, 240, 250, 1),
      primaryColorDark: const Color.fromRGBO(207, 111, 128, 1),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.red, // Your accent color
      ),
    ),
  ));
}
