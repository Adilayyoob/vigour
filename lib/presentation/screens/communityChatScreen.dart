// ignore_for_file: prefer_const_constructors_in_immutables, file_names, avoid_print

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String userName = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        userName = loggedInUser.email!;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Timestamp convertToTimestamp() {
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    print("current phone data is: $currentPhoneDate");
    return myTimeStamp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SizedBox(
          child: ListView(
            primary: false,
            padding: const EdgeInsets.only(top: 0, bottom: 10),
            children: [
              Column(
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
                      const FontBoldHeader(
                          content: "Community Chat", contentSize: 18),
                      const Spacer(
                        flex: 5,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 170,
                    child: UserInformation(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 14,
                        child: SizedBox(
                          width: 290,
                          height: 52,
                          child: InputField(
                              heading: "Enter Message Here...",
                              pass: (value) {
                                messageText = value;
                              }),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
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
                                'published_date': convertToTimestamp(),
                                'userAvatar':
                                    "https://firebasestorage.googleapis.com/v0/b/vigour-19473.appspot.com/o/users%2F$userName?alt=media"
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_upward,
                              color: Color.fromRGBO(51, 70, 105, 1),
                              size: 36,
                            )),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('published_date')
      .snapshots();

  String convertToDate(Timestamp ts) {
    int ts1 = ts.millisecondsSinceEpoch;
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts1);
    String fdatetime = DateFormat('dd-M-yyy [h:m]')
        .format(tsdate); //DateFormat() is from intl package
    print(fdatetime); //output: 04-Dec-2021
    return fdatetime;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          shrinkWrap: true,
          reverse: true,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          children:
              snapshot.data!.docs.reversed.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ChatCard(
              userImageURL: Image.network(
                data["userAvatar"],
                fit: BoxFit.cover,
              ),
              messageContent: data["message_content"],
              userName: data["username"],
              publishedDate: convertToDate(data["published_date"]),
            );
          }).toList(),
        );
      },
    );
  }
}
