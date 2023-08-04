// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './profile_screen.dart';

class CustomProgressBar extends StatelessWidget {
  final int currentLevel;
  final int goal;

  CustomProgressBar({required this.currentLevel, required this.goal});

  double calculateProgress(int currentLevel, int goal) {
    if (currentLevel > goal) {
      return 1.0;
    }
    return currentLevel / goal;
  }

  @override
  Widget build(BuildContext context) {
    double progressPercentage = calculateProgress(currentLevel, goal);

    return Container(
      height: 40.0,
      width: goal.toDouble(), // Set a fixed width for the progress bar
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: FractionallySizedBox(
        widthFactor: progressPercentage,
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    // variables

    var tempUsername = "Morgan Li"; // username until backend fixes it

    int currentSteps = 10000; // from backend later
    int goalSteps = 10000;

    int currentCalories = 1900;
    int goalCalories = 1800; // acceptable 1700 -- 1900

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 128, 128, 128),
        appBar: AppBar(title: Text("Dashboard")),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Welcome, $tempUsername",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
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
                CustomProgressBar(currentLevel: currentSteps, goal: goalSteps),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()),
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
                                builder: (context) => ProfilePage()),
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
            )));
  }
}
