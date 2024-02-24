import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static ImagePickerService instance = ImagePickerService._();

  ImagePickerService._();
  final ImagePicker _picker = ImagePicker();

  pickSingleImage() async {
    XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      throw 'failed to pick';
    }
  }
}
