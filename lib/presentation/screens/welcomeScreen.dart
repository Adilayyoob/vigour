// first screen with app logo and name
// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names,, import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vigour/presentation/components/appName.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLight.dart';
import 'package:vigour/presentation/screens/loginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // initialising variables
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    // timmer for 2 second then go to login page
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
    // setting up animation
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      upperBound: 1,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInSine);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // disposing animation controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: Container(
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeumorphicContainer(
                  spread: controller.value * 6,
                  height: 170,
                  width: 170,
                  borderRadius: 30,
                  primaryColor: Theme.of(context).primaryColor,
                  curvature: Curvature.flat,
                  child: Center(
                    child: SvgPicture.asset("assets/images/logo.svg"),
                  ),
                ),
                SizedBox(
                  height: controller.value * 135,
                ),
                AppName(),
                SizedBox(
                  height: 14,
                ),
                FontLight(content: "Your health Companion", contentSize: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
