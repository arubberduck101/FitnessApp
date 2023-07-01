import 'package:flutter/material.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  // CameraImage? _cameraImage;
  // CameraController? _cameraController;
  // bool _isDetecting = false;
  // String _result = '';

  // @override
  // void initState() {
  //   super.initState();
  //   initalizeCamera();
  //   loadModel();
  // }

  // Future<void> initializeCamera() async {
  //   final cameras = await availableCameras();
  //   final frontCamera = cameras.firstWhere(
  //       (camera) => camera.lensDirection == CameraLensDirection.front);

  //   _cameraController = CameraController(
  //     frontCamera,
  //     ResolutionPreset.high,
  //   );

  //   await _cameraController!.initialize();

  //   _cameraController!.startImageStream((CameraImage) {
  //     if (_isDetecting) return;

  //     _isDetecting = true;
  //     processCameraImage(image);
  //   });
  // }

  // Future loadModel() async {
  //   Tflite.close();
  //   await Tflite.loadModel(
  //       model: "assets/ssd_mobilenet.tflite",
  //       labels: "assets/ssd_mobilenet.txt");
  // }

  // Future<void> processCameraImage(CameraImage image) async {
  //   if (_cameraController == null) return;

  //   final img.Image rotatedImage = _rotateImage(
  //     img.copyRotate(
  //       img.Image.fromBytes(
  //         image.width,
  //         image.height,
  //         image.planes[0].bytes,
  //         format: img.Format.bgra,
  //       ),
  //       90,
  //     ),
  //   );

  //   final recognitionResult = await Tflite.runModelOnImage(
  //     path: imagePath,
  //   )

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('This is going to be our food page'),
      ),
    );
  }
}
