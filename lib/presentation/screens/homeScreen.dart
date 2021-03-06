// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, avoid_print, await_only_futures

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/models/userData.dart';
import 'package:vigour/presentation/components/appName.dart';
import 'package:vigour/presentation/components/fontBoldHeader.dart';
import 'package:vigour/presentation/components/homeContainerButton.dart';
import 'package:vigour/presentation/components/specialLine.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // initialising variables
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  bool isLoading = false;
  String _imageURl = "";
  String usersName = "";

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
        usersName = loggedInUser.email!;
        downloadURLExample();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> downloadURLExample() async {
    // getting user image url from firebase
    String? fileId = loggedInUser.email;
    setState(() => isLoading = true);
    String downloadURL =
        await FirebaseStorage.instance.ref("users/$fileId").getDownloadURL();
    setState(() => isLoading = false);
    print(downloadURL);
    setState(() {
      _imageURl = downloadURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        primary: false,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const AppName(),
                          const Spacer(
                            flex: 6,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/SettingScreen',
                                arguments: UserData(
                                    UserName: usersName, UserUrl: _imageURl),
                              );
                            },
                            child: NeumorphicContainer(
                              width: 52,
                              height: 52,
                              borderRadius: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: (_imageURl.isEmpty)
                                    ? Stack(
                                        children: [
                                          Image.asset(
                                            "assets/images/unknown_person.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                          if (isLoading)
                                            Center(
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                ),
                                              ),
                                            )
                                        ],
                                      )
                                    : Image.network(
                                        _imageURl,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 214,
                        child: SvgPicture.asset("assets/images/home_image.svg"),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: NeumorphicContainer(
                    height: MediaQuery.of(context).size.height / 1.51,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: 24,
                    primaryColor: Theme.of(context).primaryColor,
                    curvature: Curvature.flat,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: SpecialLine(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child:
                              FontBoldHeader(content: "Home", contentSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.95,
                          child: GridView.count(
                            padding: const EdgeInsets.only(
                              left: 35,
                              right: 35,
                              top: 10,
                              bottom: 10,
                            ),
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            crossAxisCount: 2,
                            scrollDirection: Axis.vertical,
                            children: [
                              HomeContainerButton(
                                content: "Medicine Reminder",
                                iconName: FontAwesomeIcons.capsules,
                                click: () {
                                  Navigator.pushNamed(
                                      context, '/MedicineReminderScreen');
                                },
                              ),
                              HomeContainerButton(
                                content: "Doctor Visit Reminder",
                                iconName: FontAwesomeIcons.hospitalUser,
                                click: () {
                                  Navigator.pushNamed(
                                      context, '/DoctorVisitReminderScreen');
                                },
                              ),
                              HomeContainerButton(
                                content: "Drink Water Reminder",
                                iconName: FontAwesomeIcons.glassWhiskey,
                                click: () {
                                  Navigator.pushNamed(
                                      context, '/DrinkWaterReminderScreen');
                                },
                              ),
                              HomeContainerButton(
                                content: "BMI Calculator",
                                iconName: FontAwesomeIcons.calculator,
                                click: () {
                                  Navigator.pushNamed(
                                      context, '/BMICalculatorScreen');
                                },
                              ),
                              HomeContainerButton(
                                content: "Document Upload Area",
                                iconName: Icons.account_balance_wallet,
                                click: () {
                                  Navigator.pushNamed(
                                      context, '/DocumentUploadArea',
                                      arguments: UserData(UserName: usersName));
                                },
                              ),
                              HomeContainerButton(
                                content: "Nutrition Charts",
                                iconName: FontAwesomeIcons.nutritionix,
                                click: () {
                                  Navigator.pushNamed(
                                      context, '/NutritionChartScreen');
                                },
                              ),
                              HomeContainerButton(
                                content: "Home Medicine Library",
                                iconName: FontAwesomeIcons.bookMedical,
                                click: () {
                                  Navigator.pushNamed(
                                      context, '/HomeMedicineLibraryScreen');
                                },
                              ),
                              HomeContainerButton(
                                content: "Exercise And Yoga Tips",
                                iconName: Icons.self_improvement,
                                click: () {
                                  Navigator.pushNamed(
                                      context, '/ExerciseAndYogaTipsScreen');
                                },
                              ),
                              HomeContainerButton(
                                content: "Community Chat",
                                iconName: Icons.question_answer,
                                click: () {
                                  Navigator.pushNamed(
                                      context, '/CommunityChatScreen');
                                },
                              ),
                              HomeContainerButton(
                                content: "Report",
                                iconName: Icons.assessment,
                                click: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/ReportScreen',
                                    arguments: UserData(UserName: usersName),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
