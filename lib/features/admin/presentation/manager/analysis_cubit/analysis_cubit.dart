import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/admin/data/model/analysis_data_model.dart';
import 'package:coffee_app/features/admin/data/repo/analysis_repo_impl.dart';
import 'package:meta/meta.dart';

part 'analysis_state.dart';

class AnalysisCubit extends Cubit<AnalysisState> {
  AnalysisCubit() : super(AnalysisInitial());

  Future<void> getDashboardAnalysis() async {
    emit(AnalysisLoading());
    final result = await AnalysisRepoImpl().fetchDashboardAnalysis();
    result.fold(
      (failure) => emit(AnalysisError()),
      (data) => emit(AnalysisLoaded(data)),
    );
  }
}
