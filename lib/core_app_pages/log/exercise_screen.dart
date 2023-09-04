import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intro_to_flutter/core_app_pages/log/log_page.dart';
import './exercise_to_calories_function.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}
//you stink

class _ExercisePageState extends State<ExercisePage> {
  String? textInput1;
  String? dropdownValue1;
  String? dropdownValue2;
  String? dropdownValue3;

  final List<String> exercises = [
    'Running',
    'Swimming',
    'Walking',
    'Hiking',
    'Spinning',
    'Kickboxing',
    'Skiing',
    'Jumping',
  ];

  final List<String> time = [
    '15 minutes',
    '30 minutes',
    '45 minutes',
    '1 hour',
  ];

  final List<String> bpm = [
    '50+ bpm',
    '60+ bpm',
    '70+ bpm',
    '80+ bpm',
    '90+ bpm',
  ];

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  void submitToFirestore() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('Not authenticated user.');
      return;
    }

    if (dropdownValue3 == null ||
        dropdownValue1 == null ||
        dropdownValue2 == null) {
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

    try {
      final snapshot = await usersCollection.doc(userID).get();
      if (snapshot.exists) {
        int? ageFromFireStore = snapshot['Age'] as int?;
        double? weightFromFireStore = snapshot['Weight'] as double?;
        double? heightFromFireStore = snapshot['Height'] as double?;
        String? genderFromFireStore = snapshot['Gender'] as String?;

        double duration = 0;

        if (dropdownValue1 == "15 minutes") {
          duration = 15;
        } else if (dropdownValue1 == "30 minutes") {
          duration = 30;
        } else if (dropdownValue1 == "45 minutes") {
          duration = 45;
        } else {
          duration = 60;
        }

        String bpmNumberString = dropdownValue2!.substring(0, 2);
        double bpmNumberDouble = double.parse(bpmNumberString);

        double calories = exerciseToCalories(
            heightFromFireStore!,
            weightFromFireStore!,
            duration,
            bpmNumberDouble,
            ageFromFireStore!,
            genderFromFireStore!);

        final Map<String, dynamic> newExerciseData = {
          'Exercise': dropdownValue3,
          'Duration': dropdownValue1,
          'BPM': dropdownValue2,
          'Calories': calories,
          'date': DateTime.now().toString().substring(0, 16),
        };

        List<dynamic>? existingExercisesArray =
            snapshot['Exercises'] as List<dynamic>?;
        if (existingExercisesArray == null) {
          existingExercisesArray = [];
        }

        existingExercisesArray.add(newExerciseData);

        await usersCollection.doc(userID).set(
          {'Exercises': existingExercisesArray},
          SetOptions(merge: true),
        );

        print("Values updated to Firestore successfully!");
        Navigator.pop(context);
      } else {
        print("User data does not exist in Firestore.");
      }
    } catch (e) {
      print("Failed to update values to Firestore: $e");
    }
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
                "Exercise(s)",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue3,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue3 = newValue!;
                  });
                },
                items: exercises.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                "Duration",
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
                items: time.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                "Performance",
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
                items: bpm.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
