// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:photo_view/photo_view.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';

class DocumentUploadAreaView extends StatelessWidget {
  const DocumentUploadAreaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    BackButtonNeo(),
                    const SizedBox(
                      width: 40,
                    ),
                    const FontBoldHeader(
                        content: "Document Upload Area", contentSize: 18),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 45,
                  height: MediaQuery.of(context).size.height - 400,
                  child: PhotoView(
                    imageProvider:
                        const AssetImage("assets/images/bill_eg.jpeg"),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
            Positioned(
              bottom: 70,
              child: ButtonSpecial(
                heading: "Share",
                click: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
