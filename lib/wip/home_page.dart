import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intro_to_flutter/firebase/db.dart';
import '../core_app_pages/status_page.dart';
import '../core_app_pages/recommendation_page.dart';
import '../core_app_pages/profile_screen.dart';
import './prgoressBar.dart';
import 'dart:core';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List _foodLog = [];

class _HomePageState extends State<HomePage> {
  String _userName = 'Placeholder'; // Initialize with an empty string

  double currentCaloriesIn = 10000; // from backend later
  double goalCaloriesIn = 10000;

  double currentCaloriesOut = 1900;
  double goalCaloriesOut = 1800; // acceptable 1700 -- 1900

  Map? userInfo;
  String? username;

  @override
  void initState() {
    super.initState();
    debugPrint("initState: Fetching user info");
    _getUserInfo();
  }

  _getUserInfo() async {
    Map? temp = await getUserInfo();

    setState(() {
      userInfo = temp;
      _userName = userInfo!["Name"];
    });

    setCaloriesIn(userInfo!);
  }

  void setCaloriesIn(Map userInfoMap) {
    List<dynamic> foodLog = userInfoMap['foodLog'];
    double totalCalories = 0;

    // Get the current date
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    // Iterate through foodLog
    // Inside the for loop
    for (var foodEntry in foodLog) {
      DateTime entryDate = DateTime.parse(foodEntry['date']);

      // Check if the entry date is on the same day (regardless of time)
      if (entryDate.year == today.year &&
          entryDate.month == today.month &&
          entryDate.day == today.day) {
        totalCalories += foodEntry['calories'];
      }
    }

    currentCaloriesIn = totalCalories;

    debugPrint("Total calories consumed today: $totalCalories");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 102, 106, 219),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Welcome, $_userName", // Display the fetched username
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Text(
                      "Calories In",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    CustomProgressBar(
                        currentLevel: currentCaloriesIn, goal: goalCaloriesIn),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text("Current Calories In: $currentCaloriesIn",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center)),
                    if (currentCaloriesIn >= goalCaloriesIn)
                      Text("Congratulations! You met your calories in goal",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Calories Out",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    CustomProgressBar(
                        currentLevel: currentCaloriesOut,
                        goal: goalCaloriesOut),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text("Current Calories Out: $currentCaloriesOut",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center)),
                    if (currentCaloriesOut > goalCaloriesOut - 100 &&
                        currentCaloriesOut < goalCaloriesOut + 100)
                      Text("Congratulations, you met your calorie outtake goal",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center),
                    if (currentCaloriesOut <= goalCaloriesOut - 100 ||
                        currentCaloriesOut >= goalCaloriesOut + 100)
                      Text("try to keep on diet",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center),
                    SizedBox(height: 50.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                          child: GestureDetector(
                            onTap: () {
                              print("Status button pressed");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StatusPage()),
                              );
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    'assets/images/exercising.jpg',
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 5.0,
                                  right: 15.0,
                                  child: Text(
                                    'Status',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecommendationPage()),
                              );
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    'assets/images/exercising.jpg',
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 5.0,
                                  right: 15.0,
                                  child: Text(
                                    'Recommendation',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ))));
  }
}
