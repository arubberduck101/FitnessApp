import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase/db.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';

class AddFoodLogPage extends StatefulWidget {
  const AddFoodLogPage({Key? key}) : super(key: key);

  @override
  State<AddFoodLogPage> createState() => _AddFoodLogPageState();
}

class _AddFoodLogPageState extends State<AddFoodLogPage> {
  File? _image;
  List? _recognitions;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadTfModel();
  }

  // this function loads the model
  loadTfModel() async {
    // await Tflite.loadModel(
    //   model: 'assets/food.tflite',
    //   labels: 'assets/food.txt',
    // );
  }

  saveFood() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    Map food = {
      'date': DateTime.now().toString().substring(0, 16),
      'food': _recognitions![0]['label']
    };

    buildLoading();
    addFoodLog(food).then((value) {
      Navigator.of(context).pop();
      snapBarBuilder('Food log was added');
    });
  }

  buildLoading() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        });
  }

  snapBarBuilder(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// gets image from camera and runs detectObject
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    print(_image);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image Selected");
      }
    });
    classifyObject(_image!);
  }

  // gets image from gallery and runs detectObject
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image Selected");
      }
      _image =
          File('assets/images/applePie.jpg'); // Change the path accordingly
    });
    classifyObject(_image!);
  }

  // this function detects the objects on the image
  classifyObject(File image) async {
    // var recognitions = await Tflite.runModelOnImage(
    //     path: image.path,
    //     imageMean: 0.0,
    //     imageStd: 255.0,
    //     asynch: true // defaults to true
    //     );

    // setState(() {
    //   _recognitions = recognitions;
    //   print(recognitions);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(70, 130, 169, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
        ),
        toolbarHeight: 100,
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 85,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _recognitions == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Please Select an Image"),
                ],
              ),
            )
          : // if not null then
          Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: ListView(
                children: [
                  Image.file(_image!),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: _recognitions!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                '${_recognitions![index]['label']}',
                                style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0),
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              flex: 6,
                              child: SizedBox(
                                height: 32.0,
                                child: Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.redAccent),
                                      value: _recognitions![index]
                                          ['confidence'],
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.2),
                                      minHeight: 50,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${(_recognitions![index]['confidence'] * 100).toStringAsFixed(0)} %',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider()),
                  ElevatedButton(
                      onPressed: () {
                        saveFood();
                      },
                      child: const Text('Save food'))
                ],
              ),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "Fltbtn2",
            onPressed: getImageFromCamera,
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: "Fltbtn1",
            onPressed: getImageFromGallery,
            child: const Icon(Icons.photo),
          ),
        ],
      ),
    );
  }
}
