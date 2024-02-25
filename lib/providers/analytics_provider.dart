import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class AnalyticsProvider with ChangeNotifier {
  XFile? image;
  bool picked = false;
  InputImage? inputImage;

  late Stream<StepCount> stepCountStream;
  late Stream<PedestrianStatus> pedestrianStatusStream;

  String status = '?', steps = '?';

  void pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    image = await imagePicker.pickImage(
      source: source,
      imageQuality: 40,
      maxHeight: 900,
      maxWidth: 900,
    );
    if (image == null) return;
    picked = true;
    inputImage = InputImage.fromFilePath(image!.path);
    notifyListeners();
  }

  void clearImage() {
    image = null;
    inputImage = null;
    picked = false;
    notifyListeners();
  }

  void onStepCount(StepCount event) {
    print(event);
    print('steps added');
    // setState(() {
    steps = event.steps.toString();
    // });
    notifyListeners();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    status = event.status;
    notifyListeners();
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    // setState(() {
    status = 'Pedestrian Status not available';
    // });
    notifyListeners();
    print(status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    // setState(() {
    steps = 'Step Count not available';
    // });
    notifyListeners();
  }

  init() async {
    await [Permission.activityRecognition].request();
    pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    stepCountStream = Pedometer.stepCountStream;
    stepCountStream.listen(onStepCount).onError(onStepCountError);
  }
}
