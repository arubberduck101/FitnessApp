import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../core_app_pages/status_page.dart';
import '../core_app_pages/recommendation_page.dart';
import '../core_app_pages/profile_screen.dart';
import './prgoressBar.dart';

class HomePage extends StatefulWidget {
  final String userUID;

  const HomePage({Key? key, required this.userUID}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userName = 'Placeholder'; // Initialize with an empty string

  @override
  void initState() {
    super.initState();
    debugPrint("initState: Fetching user name");
    _fetchUserName(); // Fetch the user's name when the widget is initialized
  }

  void _fetchUserName() async {
    debugPrint("cool this works");
    try {
      // Fetch the document using userUID as the document ID
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(widget.userUID)
              .get();
      debugPrint(documentSnapshot.toString());
      if (documentSnapshot.exists) {
        // If the document exists, extract the name field
        setState(() {
          _userName = documentSnapshot.data()!['Name'];
        });
      }
    } catch (e) {
      debugPrint('Error fetching user name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var tempUsername = _userName; // Use the fetched username

    int currentSteps = 10000; // from backend later
    int goalSteps = 10000;

    int currentCalories = 1900;
    int goalCalories = 1800; // acceptable 1700 -- 1900

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
                      "Steps",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    CustomProgressBar(
                        currentLevel: currentSteps, goal: goalSteps),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text("Current Steps: $currentSteps",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center)),
                    if (currentSteps >= goalSteps)
                      Text("Congratulations! You met your step goal",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Calorie Intake",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    CustomProgressBar(
                        currentLevel: currentCalories, goal: goalCalories),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text("Current Calories: $currentCalories",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center)),
                    if (currentCalories > goalCalories - 100 &&
                        currentCalories < goalCalories + 100)
                      Text("Congratulations, you met your calorie intake goal",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center),
                    if (currentCalories <= goalCalories - 100 ||
                        currentCalories >= goalCalories + 100)
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
