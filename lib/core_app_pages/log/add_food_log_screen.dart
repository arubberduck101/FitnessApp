import 'package:flutter/material.dart';
import '../../firebase/db.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class AddFoodLogPage extends StatefulWidget {
  const AddFoodLogPage({Key? key}) : super(key: key);

  @override
  State<AddFoodLogPage> createState() => _AddFoodLogPageState();
}

class _AddFoodLogPageState extends State<AddFoodLogPage> {
  File? _image;
  List? _recognitions;
  bool isPredictionCorrect = true;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadTfModel();
  }

  loadTfModel() async {
    await Tflite.loadModel(
      model: 'assets/food.tflite',
      labels: 'assets/food.txt',
    );
    if (_image != null) {
      classifyObject(_image!);
    }
  }

  saveFood() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    String foodName;

    if (isPredictionCorrect) {
      foodName = _recognitions![0]['label'];
    } else {
      foodName = foodNameController.text;
    }
    Map food = {
      'date': DateTime.now().toString().substring(0, 16),
      'food': foodName,
      'calories': int.parse(caloriesController.text),
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
      },
    );
  }

  snapBarBuilder(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    classifyObject(_image!);
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    classifyObject(_image!);
  }

  classifyObject(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      asynch: true,
    );
    setState(() {
      _recognitions = recognitions;
    });
  }

  TextEditingController foodNameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Food"),
        backgroundColor: Color.fromARGB(255, 65, 117, 33),
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
          : Padding(
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
                                fontSize: 20.0,
                              ),
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
                                      Colors.redAccent,
                                    ),
                                    value: _recognitions![index]['confidence'],
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
                                        fontSize: 20.0,
                                      ),
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
                        const Divider(),
                  ),
                  Text("Is the prediction correct?"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isPredictionCorrect = true;
                          });
                        },
                        child: Text('Yes'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isPredictionCorrect = false;
                          });
                        },
                        child: Text('No'),
                      ),
                    ],
                  ),
                  if (isPredictionCorrect)
                    TextFormField(
                      controller: caloriesController,
                      decoration: InputDecoration(labelText: 'Calories'),
                      keyboardType: TextInputType.number,
                    )
                  else
                    Column(
                      children: [
                        TextFormField(
                          controller: foodNameController,
                          decoration: InputDecoration(labelText: 'Food Name'),
                        ),
                        TextFormField(
                          controller: caloriesController,
                          decoration: InputDecoration(labelText: 'Calories'),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ElevatedButton(
                    onPressed: () {
                      saveFood();
                    },
                    child: const Text('Save food'),
                  ),
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
