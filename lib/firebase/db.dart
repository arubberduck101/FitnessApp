import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'authentication.dart';

Future<Map?> getUserInfo() async {
  Map? data;
  String uid = AuthenticationHelper().uid;
  await FirebaseFirestore.instance
      .collection("exercise")
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

Future<Map?> getVideoFiles() async {
  Map files = {};
  try {
    final storageRef = FirebaseStorage.instance.ref('exercise');
    ListResult listResult = await storageRef.listAll();
    for (var item in listResult.items) {
      // The items under storageRef.

      print('name:${item.name}');
      item.getDownloadURL().then((url) {
        files[item.name] = url;
      });
    }
    return files;
  } on FirebaseException catch (e) {
    print('===== error ========');
    print(e);
    return files;
  }
}
