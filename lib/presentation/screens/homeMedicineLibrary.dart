// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/backButtonNeo.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/fontLight.dart';
import 'package:vigour/presentation/components/fontLightHeader.dart';
import 'package:vigour/presentation/components/fontLightRed.dart';
import 'package:vigour/presentation/components/theMainCard.dart';
import 'package:vigour/presentation/screens/ViewScreenTwo.dart';

class HomeMedicineLibraryScreen extends StatefulWidget {
  const HomeMedicineLibraryScreen({Key? key}) : super(key: key);

  @override
  State<HomeMedicineLibraryScreen> createState() =>
      _HomeMedicineLibraryScreenState();
}

class _HomeMedicineLibraryScreenState extends State<HomeMedicineLibraryScreen> {
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
              children: const [
                Spacer(
                  flex: 1,
                ),
                BackButtonNeo(),
                Spacer(
                  flex: 3,
                ),
                FontBoldHeader(
                    content: "Home Medicine Library", contentSize: 18),
                Spacer(
                  flex: 6,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width,
              child: FetchingCards(),
            ),
          ],
        ),
      ),
    );
  }
}

class FetchingCards extends StatefulWidget {
  // Collecting data from firebase 'homeMedicineLibrary' collectiion and displayind as TheMainCard in screen
  @override
  _FetchingCardsState createState() => _FetchingCardsState();
}

class _FetchingCardsState extends State<FetchingCards> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('homeMedicineLibrary')
      .orderBy('published_date')
      .snapshots();

  String convertToDate(Timestamp ts) {
    // converting Timestamp from firebase to DateTime datatype in Dart, and converted to string in 'dd-MM-yyy' format
    int ts1 = ts.millisecondsSinceEpoch;
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts1);
    String fdatetime = DateFormat('dd-MM-yyy')
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
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return TheMainCard(
                click: () async {
                  // passing data to ViewScreenTwo
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewScreenTwo(
                      screenHeader: "Home Medicine Library",
                      heading: data["heading"],
                      imageURL: data["image_link"],
                      content: data["content"],
                      publishedDate: convertToDate(data["published_date"]),
                      authorName: data["author"],
                    ),
                  ));
                },
                heading: data["heading"],
                author: data["author"],
                imageUrl: data["image_link"]);
          }).toList(),
        );
      },
    );
  }
}
