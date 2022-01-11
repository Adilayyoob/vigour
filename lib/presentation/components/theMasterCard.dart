// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';

class TheMasterCard extends StatelessWidget {
  const TheMasterCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          width: 350,
          child: FontLight(content: "Friday, 24/12/2021", contentSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        NeumorphicContainer(
          height: 58,
          width: 350,
          borderRadius: 20,
          primaryColor: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  FontLightHeader(content: "Head Scan", contentSize: 18),
                  FontLight(
                    content: "IMG0002.JPEG",
                    contentSize: 14,
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              const Visibility(
                visible: true,
                child: FontLightHeader(
                  content: "3:36 PM",
                  contentSize: 24,
                ),
              ),
              const SizedBox(
                width: 70,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
