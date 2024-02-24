import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/configs/configs.dart';
import 'package:softec_app/cubits/pose_analysis/pose_analysis_cubit.dart';
import 'package:softec_app/painters/pose_painter.dart';
import 'package:softec_app/providers/analytics_provider.dart';
import 'package:softec_app/widgets/design/buttons/app_button.dart';

class PoseAnalysisScreen extends StatelessWidget {
  const PoseAnalysisScreen({super.key});
  static final _key = GlobalKey<ExpandableFabState>();
  @override
  Widget build(BuildContext context) {
    final analyticsProvider = Provider.of<AnalyticsProvider>(context);
    final analysisCubit = BlocProvider.of<PoseAnalysisCubit>(context);

    return WillPopScope(
      onWillPop: () async {
        analyticsProvider.clearImage();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pose Analysis'),
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          key: _key,
          overlayStyle: ExpandableFabOverlayStyle(
            blur: 5,
          ),
          children: [
            FloatingActionButton.small(
              heroTag: null,
              child: const Icon(Icons.camera_alt_outlined),
              onPressed: () {
                analysisCubit.clearState();
                analyticsProvider.clearImage();
                analyticsProvider.pickImage(ImageSource.gallery);
              },
            ),
            FloatingActionButton.small(
              heroTag: null,
              child: const Icon(Icons.person),
              onPressed: () {
                analysisCubit.clearState();
                analyticsProvider.clearImage();
                analyticsProvider.pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
        bottomNavigationBar: analyticsProvider.image != null
            ? AppButton(
                label: 'Analyze',
                onPressed: () {
                  analysisCubit.analysePose(analyticsProvider.inputImage!);
                },
                buttonType: ButtonType.borderedSecondary,
              )
            : null,
        body: SingleChildScrollView(
          child: Padding(
            padding: Space.all(),
            child: Stack(
              children: [
                if (analyticsProvider.image != null)
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 350,
                      width: 350,
                      child: Image.file(
                        File(analyticsProvider.image!.path),
                        fit: BoxFit.cover,
                      ),
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
                          size: const Size(900, 900),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
