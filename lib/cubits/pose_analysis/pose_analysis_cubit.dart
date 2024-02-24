
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pose_analysis_state.dart';

class PoseAnalysisCubit extends Cubit<PoseAnalysisState> {
  PoseAnalysisCubit() : super(PoseAnalysisInitial());
}
