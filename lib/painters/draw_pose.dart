// import 'package:flutter/material.dart';
// import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

// class LandmarksPainter extends CustomPainter {
//   final List<Pose> poses;

//   LandmarksPainter(this.poses);

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (poses.isEmpty) return;

//     final Paint paint = Paint()
//       ..color = Colors.green
//       ..strokeWidth = 4.0
//       ..style = PaintingStyle.fill;

//     for (final pose in poses) {
//       pose.landmarks.forEach((_, landmark) {
//         // final type = landmark.type;
//         final x = landmark.x;
//         final y = landmark.y;
//         final z = landmark.z;
//         final double scaledX = x * size.width;
//         final double scaledY = y * size.height;
//         final double circleRadius = 10.0 * (1 - z);
//         canvas.drawCircle(Offset(scaledX, scaledY), circleRadius, paint);

//         // print('Landmark type: $type, x: $x, y: $y, z: $z');
//       });
//       // final double x = p.landmarks..;
//       // final double y = landmark['y'];
//       // final double z = landmark['z'];

//       // final double scaledX = x * size.width;
//       // final double scaledY = y * size.height;

//       // final double circleRadius = 10.0 * (1 - z); // Adjust radius based on z value

//       // canvas.drawCircle(Offset(scaledX, scaledY), circleRadius, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(LandmarksPainter oldDelegate) {
//     return true;
//   }
// }
