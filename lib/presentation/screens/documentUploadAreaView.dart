// ignore_for_file: file_names, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:photo_view/photo_view.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class DocumentUploadAreaView extends StatefulWidget {
  final String docImage;
  final String username;
  DocumentUploadAreaView({required this.docImage, required this.username});

  @override
  State<DocumentUploadAreaView> createState() => _DocumentUploadAreaViewState();
}

class _DocumentUploadAreaViewState extends State<DocumentUploadAreaView> {

 
  
 

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
                    const Spacer(
                      flex: 1,
                    ),
                    BackButtonNeo(),
                    const Spacer(
                      flex: 3,
                    ),
                    const FontBoldHeader(
                        content: "Document Upload Area", contentSize: 18),
                    const Spacer(
                      flex: 6,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: PhotoView(
                    imageProvider: CachedNetworkImageProvider(
                        "https://firebasestorage.googleapis.com/v0/b/vigour-19473.appspot.com/o/document%2F${widget.username}%2F${widget.docImage}?alt=media"),
                  ),
                ),
              ],
            ),
            Positioned(
              width:  MediaQuery.of(context).size.width,
              bottom: 70,
              child: Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: ButtonSpecial(
                  heading: "Share",
                  click: () async {
                  final imageurl = "https://firebasestorage.googleapis.com/v0/b/vigour-19473.appspot.com/o/document%2F${widget.username}%2F${widget.docImage}?alt=media";
                  final uri = Uri.parse(imageurl);
                  final response = await http.get(uri);
                  final bytes = response.bodyBytes;
                  final temp = await getTemporaryDirectory();
                  final path = '${temp.path}/${widget.docImage}';
                  File(path).writeAsBytesSync(bytes);
                  await Share.shareFiles([path], text: 'Image Shared');
                },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
