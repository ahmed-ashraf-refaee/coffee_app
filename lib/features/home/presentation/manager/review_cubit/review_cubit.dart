import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/home/data/data/review_model.dart';
import 'package:coffee_app/features/home/data/repo/review_repo_impl.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepoImpl _reviewRepoImpl = ReviewRepoImpl();
  final SupabaseClient _client = Supabase.instance.client;
  RealtimeChannel? _reviewsChannel;

  ReviewCubit() : super(ReviewInitial());

  Future<void> getReviews(int productId) async {
    emit(ReviewLoading());
    final result = await _reviewRepoImpl.fetchReviews(productId);
    result.fold(
      (failure) => emit(ReviewFailure(error: failure.error)),
      (reviews) => emit(ReviewSuccess(reviews: reviews)),
    );
  }

  Future<void> submitReview({
    required int productId,
    required String userId,
    required double rating,
    required String comment,
  }) async {
    emit(ReviewSubmitting());
    final result = await _reviewRepoImpl.addReview(
      productId: productId,
      userId: userId,
      rating: rating,
      comment: comment,
    );

    result.fold(
      (failure) => emit(ReviewFailure(error: failure.error)),
      (_) => emit(ReviewSubmitted()),
    );
  }

  void listenToReviews(int productId) {
    // Unsubscribe previous subscription if any
    _reviewsChannel?.unsubscribe();

    _reviewsChannel = _client
        .channel('reviews_changes_$productId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'reviews',
          callback: (payload) {
            // Filter by product_id in the callback
            final newRecord = payload.newRecord;
            if (newRecord['product_id'] == productId) {
              getReviews(productId);
            }
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'reviews',
          callback: (payload) {
            final newRecord = payload.newRecord;
            if (newRecord['product_id'] == productId) {
              getReviews(productId);
            }
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.delete,
          schema: 'public',
          table: 'reviews',
          callback: (payload) {
            final oldRecord = payload.oldRecord;
            if (oldRecord['product_id'] == productId) {
              getReviews(productId);
            }
          },
        )
        .subscribe();
  }

  @override
  Future<void> close() async {
    await _reviewsChannel?.unsubscribe();
    return super.close();
  }
}
