// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, unused_import

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntButton.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';

class PopCard extends StatelessWidget {
  const PopCard({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      spread: 0,
      height: 600,
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
            height: 34,
          ),
          const FontLightHeader(content: "Login", contentSize: 28),
          const SizedBox(
            height: 50,
          ),
           InputField(
            heading: "Username",
            pass: (value){},
          ),
          const SizedBox(
            height: 35,
          ),
          InputField(
            heading: "Password",
            pass: (value){},
          ),
          const SizedBox(
            height: 50,
          ),
          ButtonSpecial(
            heading: "Login",
            click: () {
              Navigator.pushNamed(context, '/HomeScreen');
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const FontLight(content: "Or", contentSize: 16),
          const SizedBox(
            height: 20,
          ),
          const FontLight(content: "Don’t have an account?", contentSize: 16),
          FontLightButton(
            content: "Sign up now",
            contentSize: 16,
            click: () {
              Navigator.pushNamed(context, '/SignupScreen');
            },
          )
        ],
      ),
    );
  }
}
