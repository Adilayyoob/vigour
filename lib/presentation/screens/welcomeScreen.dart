// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names,, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vigour/presentation/components/appName.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLignt.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/LoginScreen');
        },
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
                  height: 135,
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
