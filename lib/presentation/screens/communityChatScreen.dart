// ignore_for_file: prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/chatCard.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityChatScreen extends StatefulWidget {
  CommunityChatScreen({Key? key}) : super(key: key);

  @override
  _CommunityChatScreenState createState() => _CommunityChatScreenState();
}

class _CommunityChatScreenState extends State<CommunityChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  String messageText = "";

   @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try{
      final user = await _auth.currentUser;
      if(user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              child: ListView(
                padding: const EdgeInsets.only(top: 0),
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
                            width: 65,
                          ),
                          const FontBoldHeader(
                              content: "Community Chat", contentSize: 18),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 150,
                        child: ListView(
                          padding: const EdgeInsets.only(
                              top: 0, left: 20, right: 20),
                          children: const [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 350,
                              child: FontLight(
                                  content: "Friday, 24/12/2021",
                                  contentSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ChatCard(
                                userName: "Sara_Yacub",
                                messageContent:
                                    "Lorem Ipsum is simply dummy text of the printing addilg func",
                                userImageURL:
                                    "assets/images/unknown_person.jpg"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  SizedBox(
                    width: 290,
                    height: 52,
                    child: InputField(
                        heading: "Enter Message Here...",
                        pass: (value) {
                          messageText = value;
                        }),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  NeumorphicContainer(
                    height: 52,
                    width: 52,
                    borderRadius: 30,
                    primaryColor: Theme.of(context).primaryColor,
                    child: IconButton(
                        onPressed: () {
                          _firestore.collection('messages').add({
                            'message_content': messageText,
                            'username': loggedInUser.email,
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_upward,
                          color: Color.fromRGBO(51, 70, 105, 1),
                          size: 36,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
