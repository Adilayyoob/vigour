// ignore_for_file: file_names, avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vigour/presentation/components/buttonSpecial.dart';
import 'package:vigour/presentation/components/fontLight.dart';
import 'package:vigour/presentation/components/fontLightButton.dart';
import 'package:vigour/presentation/components/fontLightHeader.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:vigour/presentation/components/userImageAdd.dart';
import 'package:vigour/presentation/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // initialising variables
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String username = "";
  String password = "";
  String rePassword = "";
  File? pickedImage;
  FirebaseStorage storage = FirebaseStorage.instance;
  late File imageFile;

  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage
  Future<void> _upload() async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) {}
      final String fileName = path.basename(pickedImage!.path);
      imageFile = File(pickedImage.path);
      setState(() => this.pickedImage = imageFile);
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
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        primary: false,
        children: [
          NeumorphicContainer(
            spread: 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            borderRadius: 24,
            primaryColor: Theme.of(context).primaryColor,
            curvature: Curvature.flat,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const SpecialLine(),
                  const Spacer(
                    flex: 1,
                  ),
                  const FontLightHeader(content: "Sign up", contentSize: 28),
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: 170,
                    height: 170,
                    child: UserImageAdd(
                        clicked: () {
                          _upload();
                        },
                        imageURL: pickedImage != null
                            ? Image.file(
                                pickedImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/images/unknown_person.jpg",
                                fit: BoxFit.cover,
                              )),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  InputField(
                    keyboard: TextInputType.emailAddress,
                    heading: "Email ID",
                    pass: (value) {
                      username = value;
                    },
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  InputField(
                    passwordHidden: true,
                    heading: "Password",
                    pass: (value) {
                      password = value;
                    },
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  InputField(
                    passwordHidden: true,
                    heading: "Re-enter Password",
                    pass: (value) {
                      rePassword = value;
                    },
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  isLoading
                      ? Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        )
                      : ButtonSpecial(
                          heading: "Sign up",
                          click: () async {
                            if (password == rePassword &&
                                password != "" &&
                                rePassword != "") {
                              if (pickedImage != null) {
                                try {
                                  final newUser = await _auth
                                      .createUserWithEmailAndPassword(
                                          email: username, password: password);
                                  if (newUser != null) {
                                    _uploadImgeToFirebase();
                                    Navigator.pop(context, true);
                                  }
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    content: Text(e.toString()),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } else {
                                const snackBar = SnackBar(
                                  content: Text('Pick a user image!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Password No Match!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        ),
                  const Spacer(
                    flex: 1,
                  ),
                  const FontLight(content: "Or", contentSize: 16),
                  const Spacer(
                    flex: 1,
                  ),
                  const FontLight(
                      content: "Already have an account?", contentSize: 16),
                  FontLightButton(
                    content: "Login now",
                    contentSize: 16,
                    click: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
