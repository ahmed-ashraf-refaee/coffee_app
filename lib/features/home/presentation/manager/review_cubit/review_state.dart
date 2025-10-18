part of 'review_cubit.dart';

@immutable
abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {
  final List<ReviewModel> reviews;
  ReviewSuccess({required this.reviews});
}

class ReviewFailure extends ReviewState {
  final String error;
  ReviewFailure({required this.error});
}

class ReviewSubmitting extends ReviewState {}

class ReviewSubmitted extends ReviewState {}
