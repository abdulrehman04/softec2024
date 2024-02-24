part of 'pose_analysis_cubit.dart';

sealed class PoseAnalysisState extends Equatable {
  final String? message;
  const PoseAnalysisState({this.message});

  @override
  List<Object?> get props => [message];
}

final class PoseAnalysisInitial extends PoseAnalysisState {}

final class PoseAnalysisLoading extends PoseAnalysisState {}

final class PoseAnalysisSuccess extends PoseAnalysisState {}

final class PoseAnalysisFailure extends PoseAnalysisState {
  const PoseAnalysisFailure({required String message}) : super(message: message);
}

