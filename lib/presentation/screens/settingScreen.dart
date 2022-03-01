// ignore_for_file: file_names

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/models/userData.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:vigour/presentation/components/staticButtonSpacial.dart';
import 'package:vigour/presentation/components/switchButton.dart';
import 'package:vigour/presentation/components/userImageAdd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _auth = FirebaseAuth.instance;
  String imageUrl = "";
  String username = "";
  File? pickedImage;
  FirebaseStorage storage = FirebaseStorage.instance;
  late File imageFile;

  bool isSwitched = false;
  bool isLoading = false;

  Future<void> _upload() async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) {}
      final String fileName = path.basename(pickedImage!.path);
      imageFile = File(pickedImage.path);
      setState(() => this.pickedImage = imageFile);
      _uploadImgeToFirebase();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future _uploadImgeToFirebase() async {
    try {
      // Uploading the selected image with some custom meta data
      setState(() => isLoading = true);
      await storage.ref("users/$username").putFile(
          imageFile,
          SettableMetadata(customMetadata: {
            'uploaded_by': username,
            'description': 'profile_vigour'
          }));

      // Refresh the UI
      setState(() => isLoading = false);
      int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserData;
    username = args.UserName;
    imageUrl = args.UserUrl;
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    BackButtonNeo(),
                    const Spacer(
                      flex: 3,
                    ),
                    const FontBoldHeader(content: "Settings", contentSize: 18),
                    const Spacer(
                      flex: 6,
                    ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
                SizedBox(
                  width: 170,
                  height: 170,
                  child: isLoading
                      ? Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        )
                      : UserImageAdd(
                          clicked: () {
                            _upload();

                          },
                          imageURL: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const Spacer(
                  flex: 1,
                ),
                FontBoldHeader(content: args.UserName, contentSize: 20),
                const Spacer(
                  flex: 35,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: NeumorphicContainer(
                height: MediaQuery.of(context).size.height / 1.65,
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
                      
                      const Spacer(
                        flex: 1,
                      ),
                      const StaticButtonSpacial(
                          heading: "Help",
                          content:
                              "Vigour-your health companion is a health care related mobile application that helps people to take care of their heath.It provides services such as medicine and doctor visit reminder,drink water reminder BMI calculator, nutrition chat and yoga tips.\nOur app is completely secure and your details are safe with us. This app only support  English language. It is also  available for you  at 24 hours and you can check it from wherever you want. It could be connected to any of your devices and ensure your safety. It is simple and accurate app and also easy to use for any age groups. We are sure that, you will have a excellent User experience."),
                      const Spacer(
                        flex: 1,
                      ),
                      const StaticButtonSpacial(
                          heading: "About",
                          content:
                              "The application is made as project work by the Farook college 3rd year Bsc CS students.This app is developed in flutter for both Android and iOS platform.\n\nDeveloper details\n\nAdil Ayyoob\n+91 81292 65497\nadilkuyyo@gmail.com\n\nRaniya Jubin\n+91 90487 71119\njubinraniya@gmail.com\n\nRishana Akbar Ali\n+91 90618 00875\nrish86060@gmail.com\n\nThoufiq\n+91 70349 80196\nthoufiqpk9@gmail.com\n\nHari Krishnan T\n+91 83010 33521\nhk5115178@gmail.com"),
                      const Spacer(
                        flex: 1,
                      ),
                      const StaticButtonSpacial(
                          heading: "Invite A Friend", content: ""),
                      const Spacer(
                        flex: 2,
                      ),
                      ButtonSpecial(
                        heading: "Logout",
                        click: () {
                          _auth.signOut();
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);
                        },
                      ),
                      const Spacer(
                        flex: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
