import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class AnalysisLayer {
  static final _options = PoseDetectorOptions();
  static final _poseDetector = PoseDetector(options: _options);

  Future<List<Pose>> processImage(InputImage image) async {
    try {
      final List<Pose> poses = await _poseDetector.processImage(image);
      return poses;
    } catch (e) {
      debugPrint('Error: $e');
      throw('Internal server error');
    }
  }
}
