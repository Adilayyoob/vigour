// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntButton.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:vigour/presentation/components/userImageAdd.dart';
import 'package:vigour/presentation/screens/loginScreen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          NeumorphicContainer(
            spread: 0,
            height: MediaQuery.of(context).size.height,
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
                const FontLightHeader(content: "Sign up", contentSize: 28),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  width: 170,
                  height: 170,
                  child: UserImageAdd(),
                ),
                const SizedBox(
                  height: 30,
                ),
                InputField(
                  heading: "Username",
                  pass: (value) {},
                ),
                const SizedBox(
                  height: 35,
                ),
                InputField(
                  heading: "Password",
                  pass: (value) {},
                ),
                const SizedBox(
                  height: 35,
                ),
                InputField(
                  heading: "Re-enter Password",
                  pass: (value) {},
                ),
                const SizedBox(
                  height: 50,
                ),
                ButtonSpecial(
                  heading: "Sign up",
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
                const FontLight(
                    content: "Already have an account?", contentSize: 16),
                FontLightButton(
                  content: "Login now",
                  contentSize: 16,
                  click: () {
                    Navigator.pop(context, true);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
