// ignore_for_file: file_names, avoid_print

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
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  String username = "";
  String password = "";
  String rePassword = "";
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
                  heading: "Email ID",
                  pass: (value) {
                    username = value;
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
                InputField(
                  passwordHidden: true,
                  heading: "Password",
                  pass: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
                InputField(
                  passwordHidden: true,
                  heading: "Re-enter Password",
                  pass: (value) {},
                ),
                const SizedBox(
                  height: 50,
                ),
                ButtonSpecial(
                  heading: "Sign up",
                  click: () async {
                    if (password == rePassword) {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: username, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, '/HomeScreen');
                        }
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Password Error!"),
                          content: const Text(
                            "Password not matching.",
                            style: TextStyle(color: Colors.red),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      );
                    }
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
