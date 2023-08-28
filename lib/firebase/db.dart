import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';

Future<Map?> getUserInfo() async {
  Map? data;
  String uid = AuthenticationHelper().uid;
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      data = documentSnapshot.data() as Map?;
      print('Document data: ${documentSnapshot.data()}');
    } else {
      print('Document does not exist on the database');
    }
  });

  return data;
}

Future<bool> editUserInfo(Map<String, dynamic> data) async {
  String uid = AuthenticationHelper().uid;
  List logs = await getExerciseLog();
  data['exerciseLog'] = logs;
  FirebaseFirestore.instance.collection("exercise").doc(uid).set(data);
  return true;
}

Future<List> getExerciseLog() async {
  List log = [];
  await getUserInfo().then((data) {
    try {
      List tempList = data!['exerciseLog'];
      log = tempList;
    } catch (_) {
      print('The date does not have event');
    }
  });
  return log;
}

Future<bool> addExerciseLog(Map data) async {
  String uid = AuthenticationHelper().uid;
  List exerciseLog = await getExerciseLog();
  exerciseLog.add(data);
  FirebaseFirestore.instance
      .collection("exercise")
      .doc(uid)
      .update({'exerciseLog': exerciseLog});
  return true;
}

Future<Map> getVideoFiles() async {
  Map files = {};
  try {
    // Reference to the "videos" collection in Firestore
    CollectionReference videosRef =
        FirebaseFirestore.instance.collection('exercise');

    // Fetch all documents in the "videos" collection
    QuerySnapshot snapshot = await videosRef.get();

    // Iterate through each document and add the video name and URL to the files Map
    for (var doc in snapshot.docs) {
      String name = doc['name'];
      String url = doc['url'];
      print(url);
      files[name] = url;
    }

    return files;
  } catch (e) {
    print('===== error ========');
    print(e);
    return files;
  }
}

Future<List> getFoodLog() async {
  List log = [];
  await getUserInfo().then((data) {
    try {
      List tempList = data!['foodLog'];
      log = tempList;
    } catch (_) {
      print('The date does not have event');
    }
  });
  return log;
}

Future<bool> addFoodLog(Map data) async {
  String uid = AuthenticationHelper().uid;
  List foodLog = await getFoodLog();
  foodLog.add(data);
  FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .update({'foodLog': foodLog});
  return true;
}
