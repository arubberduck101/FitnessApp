// CURRENTLY WORKING ON THIS DO NOT TOUCH

// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  String? dropdownValue1;
  String? dropdownValue2;

  final List<String> mealtime = [
    'Breakfast',
    'Lunch',
    'Dinner',
  ];

  // Find an API with a food database to reference from
  final List<String> food = [
    'Banana',
    'Apple',
    'Chocolate',
    'etc.',
  ];

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  void submitToFirestore() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('Not authenticated user.');
      return;
    }

    if (dropdownValue1 == null || dropdownValue2 == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Missing Fields'),
            content: Text('Please fill out all the fields.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    final userID = currentUser.uid;

    final Map<String, dynamic> foodData = {
      'Meal Time': dropdownValue1,
      'Food': dropdownValue2,
      'Portion Size': selectedGrams,
      // 'Calories': selectedCalories,
    };

    try {
      usersCollection.doc(userID).set(
        {'Diet': foodData},
        SetOptions(merge: true),
      );
      print("Values updated to Firestore successfully!");
      Navigator.pop(context);
    } catch (e) {
      print("Failed to update values to Firestore.");
    }
  }

  TextEditingController _calorieController = TextEditingController();

  int selectedGrams = 0;
  int selectedCalories = 0;
  FixedExtentScrollController gramScrollController =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController calorieScrollController =
      FixedExtentScrollController(initialItem: 0);

  @override
  void initState() {
    super.initState();
    gramScrollController =
        FixedExtentScrollController(initialItem: selectedGrams);
    calorieScrollController =
        FixedExtentScrollController(initialItem: selectedCalories);
  }

  @override
  void dispose() {
    gramScrollController.dispose();
    calorieScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises"),
        backgroundColor: Color.fromARGB(255, 65, 117, 33),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Meal Time",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue1,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue1 = newValue!;
                  });
                },
                items: mealtime.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                "Select Food",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue2,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue2 = newValue!;
                  });
                },
                items: food.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                'Portion Size',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              Container(
                height: 100,
                child: ListWheelScrollView(
                  controller: gramScrollController,
                  itemExtent: 40,
                  diameterRatio: 1.5,
                  physics: FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedGrams = index;
                      print('Grams: $selectedGrams');
                    });
                  },
                  children: List.generate(101, (index) {
                    return Text(
                      '$index',
                    );
                  }),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Calories Consumed',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              TextField(
                controller: _calorieController,
                decoration: InputDecoration(
                  hintText: 'Enter Calories Consumed',
                ),
              ),
              // Container(
              //   height: 100,
              //   child: ListWheelScrollView(
              //     controller: calorieScrollController,
              //     itemExtent: 40,
              //     diameterRatio: 1.5,
              //     physics: FixedExtentScrollPhysics(),
              //     onSelectedItemChanged: (index) {
              //       setState(() {
              //         selectedCalories = index;
              //         print('Calories: $selectedCalories');
              //       });
              //     },
              //     children: List.generate(101, (index) {
              //       return Text(
              //         '$index',
              //       );
              //     }),
              //   ),
              // ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  submitToFirestore();
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
