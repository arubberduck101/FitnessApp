import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

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

  void submitToFirestore() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('Not authentificated user.');
      return;
    }

    final userID = currentUser.uid;

    final Map<String, dynamic> exerciseData = {
      'Exercise': dropdownValue3,
      'Duration': dropdownValue1,
      'BPM': dropdownValue2,
    };

    try {
      usersCollection.doc(userID).set(
        {'Exercises': exerciseData},
        SetOptions(merge: true),
      );
      print("Values updated to Firestore successfully!");
    } catch (e) {
      print("Values failed to updated to Firestore.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises"),
        backgroundColor: Color.fromARGB(255, 65, 117, 33),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "What type of exercise did you do?",
            //   style: TextStyle(
            //     fontSize: 18,
            //   ),
            // ),
            // TextField(
            //   onChanged: (value) {
            //     setState(() {
            //       textInput1 = value;
            //     });
            //   },
            // ),
            SizedBox(height: 20.0),
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
            Center(
              child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
