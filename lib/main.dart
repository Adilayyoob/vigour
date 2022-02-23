// @dart=2.9
// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vigour/presentation/screens/BMICalculatorScreen.dart';
import 'package:vigour/presentation/screens/communityChatScreen.dart';
import 'package:vigour/presentation/screens/doctorVisitReminderScreen.dart';
import 'package:vigour/presentation/screens/documentUploadArea.dart';
import 'package:vigour/presentation/screens/documentUploadAreaView.dart';
import 'package:vigour/presentation/screens/drinkWaterReminder.dart';
import 'package:vigour/presentation/screens/exerciseAndYogaTipsScreen.dart';
import 'package:vigour/presentation/screens/homeMedicineLibrary.dart';
import 'package:vigour/presentation/screens/homeScreen.dart';
import 'package:vigour/presentation/screens/loginScreen.dart';
import 'package:vigour/presentation/screens/medicineReminder.dart';
import 'package:vigour/presentation/screens/nutritionChartScreen.dart';
import 'package:vigour/presentation/screens/ViewScreenTwo.dart';
import 'package:vigour/presentation/screens/reportScreen.dart';
import 'package:vigour/presentation/screens/settingScreen.dart';
import 'package:vigour/presentation/screens/signupScreen.dart';
import 'package:vigour/presentation/screens/welcomeScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: "/WelcomeScreen",
    routes: <String, WidgetBuilder>{
      '/WelcomeScreen': (BuildContext context) => const WelcomeScreen(),
      '/LoginScreen': (BuildContext context) => const LoginScreen(),
      '/SignupScreen': (BuildContext context) => SignUpScreen(),
      '/HomeScreen': (BuildContext context) => const HomeScreen(),
      '/SettingScreen': (BuildContext context) => const SettingScreen(),
      '/MedicineReminderScreen': (BuildContext context) =>
          MedicineReminderScreen(),
      '/DoctorVisitReminderScreen': (BuildContext context) =>
          DoctorVisitReminderScreen(),
      '/DrinkWaterReminderScreen': (BuildContext context) =>
          DrinkWaterReminderScreen(),
      '/BMICalculatorScreen': (BuildContext context) =>
          const BMICalculatorScreen(),
      '/DocumentUploadArea': (BuildContext context) => DocumentUploadArea(),
      '/NutritionChartScreen': (BuildContext context) =>
          const NutritionChartScreen(),
      '/HomeMedicineLibraryScreen': (BuildContext context) =>
          const HomeMedicineLibraryScreen(),
      '/ExerciseAndYogaTipsScreen': (BuildContext context) =>
          const ExerciseAndYogaTipsScreen(),
      '/CommunityChatScreen': (BuildContext context) => CommunityChatScreen(),
      '/ReportScreen': (BuildContext context) => ReportScreen(),
    },
    title: 'Vigour',
    theme: ThemeData(
      primaryColor: const Color.fromRGBO(228, 240, 250, 1),
      primaryColorDark: const Color.fromRGBO(207, 111, 128, 1),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.red, // Your accent color
      ),
    ),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', 'US'),
    ],
  ));
}
