// The card in nutrition chart screen , Exersice and yoga tips and Home medicine library

// ignore_for_file: file_names, override_on_non_overriding_member, annotate_overrides, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLight.dart';
import 'package:vigour/presentation/components/fontLightHeader.dart';

class TheMainCard extends StatelessWidget {
  final String heading;
  final String author;
  final String imageUrl;
  final VoidCallback click;
  const TheMainCard(
      {required this.heading,
      required this.author,
      required this.imageUrl,
      required this.click});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: NeumorphicContainer(
          width: MediaQuery.of(context).size.width,
          height: 85,
          borderRadius: 20,
          primaryColor: Theme.of(context).primaryColor,
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 3,
                height: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Theme.of(context).primaryColorDark),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    FontLightHeader(
                      content: heading,
                      contentSize: 18,
                      numberOfLines: 2,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    FontLight(content: author, contentSize: 14),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 10,
                child: SizedBox(
                  height: 70,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: imageUrl.isEmpty
                          ? Image.asset(
                              "assets/images/chart_eg.jpg",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
