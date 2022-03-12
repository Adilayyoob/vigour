// Ui component for uploading image
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/addButton.dart';

class UserImageAdd extends StatelessWidget {
  final VoidCallback clicked;
  final Image imageURL;
  const UserImageAdd({required this.imageURL, required this.clicked});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NeumorphicContainer(
          height: 150,
          width: 150,
          curvature: Curvature.flat,
          borderRadius: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: imageURL,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: AddButton(
            click: clicked,
          ),
        ),
      ],
    );
  }
}
