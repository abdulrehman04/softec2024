
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:softec_app/cubits/pose_analysis/analysis_layer.dart';

part 'pose_analysis_state.dart';

class PoseAnalysisCubit extends Cubit<PoseAnalysisState> {
  PoseAnalysisCubit() : super(const PoseAnalysisInitial());

  Future<void> analysePose(InputImage image) async {
    emit(const PoseAnalysisLoading());
    try {
      final List<Pose> poses = await AnalysisLayer().processImage(image);
      if (poses.isEmpty) {
        emit(const PoseAnalysisFailure(message: 'No pose detected'));
      } else {
        emit(PoseAnalysisSuccess(poses: poses));
      }
    } catch (e) {
      emit(PoseAnalysisFailure(message: e.toString()));
    }
  }  

  void clearState() {
    emit(const PoseAnalysisInitial());
  }
}
