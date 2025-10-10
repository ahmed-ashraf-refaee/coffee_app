part of 'analysis_cubit.dart';

@immutable
sealed class AnalysisState {}

final class AnalysisInitial extends AnalysisState {}
final class AnalysisLoading extends AnalysisState {}
final class AnalysisLoaded extends AnalysisState {
  final AnalysisDataModel data;
  AnalysisLoaded(this.data);
}
final class AnalysisError extends AnalysisState {


  AnalysisError();
}
