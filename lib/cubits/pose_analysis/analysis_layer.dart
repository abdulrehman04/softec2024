import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class AnalysisLayer {
  static final _options = PoseDetectorOptions();
  static final _poseDetector = PoseDetector(options: _options);

  Future<List<Pose>> processImage(InputImage image) async {
    try {
      final List<Pose> poses = await _poseDetector.processImage(image);

      for (Pose pose in poses) {
        // to access all landmarks
        pose.landmarks.forEach((_, landmark) {
          final type = landmark.type;
          final x = landmark.x;
          final y = landmark.y;

          print('Landmark type: $type, x: $x, y: $y');
        });

        // to access specific landmarks
        final landmark = pose.landmarks[PoseLandmarkType.nose];
        print(landmark);
      }

      return poses;
    } catch (e) {
      debugPrint('Error: $e');
      throw('Internal server error');
    }
  }
}
