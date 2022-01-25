// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntButton.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import "package:firebase_auth/firebase_auth.dart";

class PopCard extends StatefulWidget {
  PopCard({Key? key}) : super(key: key);

  @override
  State<PopCard> createState() => _PopCardState();
}

class _PopCardState extends State<PopCard> {
  final _auth = FirebaseAuth.instance;
  String username = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      spread: 0,
      height: MediaQuery.of(context).size.height - 220,
      width: MediaQuery.of(context).size.width,
      borderRadius: 24,
      primaryColor: Theme.of(context).primaryColor,
      curvature: Curvature.flat,
      child: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            const SpecialLine(),
            const Spacer(
              flex: 2,
            ),
            const FontLightHeader(content: "Login", contentSize: 28),
            const Spacer(
              flex: 2,
            ),
            InputField(
              keyboard: TextInputType.emailAddress,
              heading: "Email ID",
              pass: (value) {
                username = value;
              },
            ),
            const Spacer(
              flex: 1,
            ),
            InputField(
              passwordHidden: true,
              heading: "Password",
              pass: (value) {
                password = value;
              },
            ),
            const Spacer(
              flex: 2,
            ),
            ButtonSpecial(
              heading: "Login",
              click: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: username, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, '/HomeScreen');
                  }
                } catch (e) {
                  final snackBar = SnackBar(
                    content: Text(e.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
            const Spacer(
              flex: 1,
            ),
            const FontLight(content: "Or", contentSize: 16),
            const Spacer(
              flex: 1,
            ),
            const FontLight(content: "Don’t have an account?", contentSize: 16),
            FontLightButton(
              content: "Sign up now",
              contentSize: 16,
              click: () {
                Navigator.pushNamed(context, '/SignupScreen');
              },
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
