import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/admin/data/model/analysis_data_model.dart';

import 'package:dartz/dartz.dart';

abstract class AnalysisRepo {
  Future<Either<Failure, AnalysisDataModel>> fetchDashboardAnalysis();
}
