// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, unused_import

import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vigour/models/service/preference_service.dart';
import 'package:vigour/models/userDataSaveModel.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntButton.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _preferenceService = PreferenceService();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String preUser = "";
  String username = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    _populateFields();
  }

  Future _populateFields() async {
    final userSaveGet = await _preferenceService.getUser();
    if (userSaveGet.UserName != "" && userSaveGet.UserPassword != "") {
      preUser = userSaveGet.UserName;
      username = userSaveGet.UserName;
      password = userSaveGet.UserPassword;
      LoginClick();
    }
  }

  Future<void> SetClear() async {
    Timer(Duration(seconds: 2), () {
      exit(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.asset("assets/images/login_image.jpg"),
            Positioned(
              bottom: 0,
              child: NeumorphicContainer(
                spread: 0,
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.width,
                borderRadius: 24,
                primaryColor: Theme.of(context).primaryColor,
                curvature: Curvature.flat,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
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
                        click: () {
                          LoginClick();
                        },
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      const FontLight(content: "Or", contentSize: 16),
                      const Spacer(
                        flex: 1,
                      ),
                      const FontLight(
                          content: "Don’t have an account?", contentSize: 16),
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
              ),
            ),
            if (isLoading)
              Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  void _saveUser() {
    final userSaveSet =
        UserDataSaveModel(UserName: username, UserPassword: password);
    _preferenceService.saveUser(userSaveSet);
  }

  Future LoginClick() async {
    try {
      setState(() => isLoading = true);
      final user = await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      setState(() => isLoading = false);
      if (user != null) {
        print(preUser);
        print(username);
        if (preUser == username || preUser=="") {
          _saveUser();
          preUser = username;
          Navigator.pushNamed(context, '/HomeScreen');
        } else {
          
          //delete all cache app data(new user detected)
          const snackBar = SnackBar(
            content: Text("New User Detected! Please Clear App Data From Settings."),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          SetClear();
        }
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() => isLoading = false);
    }
  }
}
