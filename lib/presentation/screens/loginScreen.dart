// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, unused_import

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/popCard.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  
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
            const Positioned(
              bottom: 0,
              child: PopCard(),
            )
          ],
        ),
      ),
    );
  }
}
