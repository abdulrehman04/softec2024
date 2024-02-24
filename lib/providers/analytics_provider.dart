import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:image_picker/image_picker.dart';

class AnalyticsProvider with ChangeNotifier {
  XFile? image;
  bool picked = false;
  InputImage? inputImage;

  void pickImage() async {
    final imagePicker = ImagePicker();
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    picked = true;
    inputImage = InputImage.fromFilePath(image!.path);
    print(inputImage!.type.name);


    // print(inputImage!.metadata?.size);
    // print(inputImage!.metadata?.rotation);
    notifyListeners();
  }

  void clearImage() {
    image = null;
    inputImage = null;
    picked = false;
    notifyListeners();
  }
}
