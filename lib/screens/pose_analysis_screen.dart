import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/cubits/pose_analysis/pose_analysis_cubit.dart';
import 'package:softec_app/painters/draw_pose.dart';
import 'package:softec_app/painters/pose_painter.dart';
import 'package:softec_app/providers/analytics_provider.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';

class PoseAnalysisScreen extends StatelessWidget {
  const PoseAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final analyticsProvider = Provider.of<AnalyticsProvider>(context);
    final analysisCubit = BlocProvider.of<PoseAnalysisCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Analysis'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          analyticsProvider.pickImage();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: AppButton(
        label: 'Analyze',
        onPressed: () {
          analysisCubit.analysePose(analyticsProvider.inputImage!);
        },
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            if (analyticsProvider.image != null)
              SizedBox(
                height: 350,
                width: 350,
                child: Image.file(
                  File(analyticsProvider.image!.path),
                  fit: BoxFit.cover,
                ),
              ),
            BlocBuilder<PoseAnalysisCubit, PoseAnalysisState>(
              builder: (context, state) {
                if (state is PoseAnalysisSuccess) {
                  final poses = state.poses;
                  final painter = PosePainter(
                    poses!,
                    const Size(900, 900),
                    InputImageRotation.rotation90deg,
                    CameraLensDirection.back,
                  );
                  return SizedBox(
                    height: 350,
                    width: 350,
                    child: CustomPaint(
                      painter: painter,
                      size: const Size(700, 700),
                    ),
                  );
                }
                // return Positioned(
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   child: AppButton(
                //     label: 'Analyze',
                //     onPressed: () {
                //       analysisCubit.analysePose(analyticsProvider.inputImage!);
                //     },
                //   ),
                // );
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
