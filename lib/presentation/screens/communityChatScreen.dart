// ignore_for_file: prefer_const_constructors_in_immutables, file_names, avoid_print

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/chatCard.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLight.dart';
import 'package:vigour/presentation/components/fontLightHeader.dart';
import 'package:vigour/presentation/components/fontLightRed.dart';
import 'package:vigour/presentation/components/inputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityChatScreen extends StatefulWidget {
  CommunityChatScreen({Key? key}) : super(key: key);

  @override
  _CommunityChatScreenState createState() => _CommunityChatScreenState();
}

class _CommunityChatScreenState extends State<CommunityChatScreen> {
  // initialising variables
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
    // getting the user of the app
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
    // Converting current time to Timestamp to store in firebase
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
                    children: const [
                      Spacer(
                        flex: 1,
                      ),
                      BackButtonNeo(),
                      Spacer(
                        flex: 3,
                      ),
                      FontBoldHeader(
                          content: "Community Chat", contentSize: 18),
                      Spacer(
                        flex: 6,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.25,
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
                              // adding message typed by user to firebase
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
  // Collecting data from firebase 'message' collectiion and displayind as chatCard in screen
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('published_date')
      .snapshots();

  String convertToDate(Timestamp ts) {
    // converting Timestamp from firebase to DateTime datatype in Dart, and converted to string in 'dd-MM-yyy [h:m]' format
    int ts1 = ts.millisecondsSinceEpoch;
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts1);
    String fdatetime = DateFormat('dd-MM-yyy [h:m]')
        .format(tsdate); //DateFormat() is from intl package
    print(fdatetime);
    return fdatetime;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child:
                FontLightRed(content: 'Something went wrong', contentSize: 14),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          );
        }
        return ListView(
          shrinkWrap: true,
          reverse: true,
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
