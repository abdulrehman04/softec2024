part of 'pose_analysis_cubit.dart';

sealed class PoseAnalysisState extends Equatable {
  final String? message;
  final List<Pose>? poses;
  const PoseAnalysisState({this.message, this.poses});

  @override
  List<Object?> get props => [message];
}

final class PoseAnalysisInitial extends PoseAnalysisState {
  const PoseAnalysisInitial();
}

final class PoseAnalysisLoading extends PoseAnalysisState {
  const PoseAnalysisLoading();
}

final class PoseAnalysisSuccess extends PoseAnalysisState {
  const PoseAnalysisSuccess({required List<Pose> poses}) : super(poses: poses);
}

final class PoseAnalysisFailure extends PoseAnalysisState {
  const PoseAnalysisFailure({required String message}) : super(message: message);
}

