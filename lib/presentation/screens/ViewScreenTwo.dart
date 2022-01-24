// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/fontLigntRed.dart';
import 'package:vigour/presentation/components/specialLine.dart';

class ViewScreenTwo extends StatelessWidget {
  final String screenHeader;
  final String heading;
  final String imageURL;
  final String content;
  final String publishedDate;
  final String authorName;

  const ViewScreenTwo(
      {Key? key,
      required this.screenHeader,
      required this.heading,
      required this.content,
      required this.imageURL,
      required this.publishedDate,
      required this.authorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              children: [
                const Spacer(
                  flex: 1,
                ),
                BackButtonNeo(),
                const Spacer(
                  flex: 3,
                ),
                FontBoldHeader(content: screenHeader, contentSize: 18),
                const Spacer(
                  flex: 6,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: NeumorphicContainer(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.18,
                borderRadius: 20,
                primaryColor: Theme.of(context).primaryColor,
                child: ListView(
                  padding: const EdgeInsets.only(left: 15, right: 15,bottom: 10),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const SpecialLine(),
                        const SizedBox(
                          height: 20,
                        ),
                        FontLightHeader(
                          content: heading,
                          contentSize: 24,
                          numberOfLines: 25,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 343,
                          height: 200,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: imageURL.isEmpty
                                  ? Image.asset(
                                      "assets/images/chart_eg.jpg",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      imageURL,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FontLight(
                          content: content,
                          contentSize: 16,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReturnFooter(
                          autherName: authorName,
                          datePublished: publishedDate,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReturnFooter extends StatelessWidget {
  final String autherName;
  final String datePublished;
  const ReturnFooter({required this.autherName, required this.datePublished});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const FontLightRed(content: "Author:", contentSize: 14),
            const SizedBox(
              width: 5,
            ),
            FontLight(
              content: autherName,
              contentSize: 14,
            ),
          ],
        ),
        Row(
          children: [
            const FontLightRed(content: "Published Date:", contentSize: 14),
            const SizedBox(
              width: 5,
            ),
            FontLight(
              content: datePublished,
              contentSize: 14,
            ),
          ],
        ),
      ],
    );
  }
}
