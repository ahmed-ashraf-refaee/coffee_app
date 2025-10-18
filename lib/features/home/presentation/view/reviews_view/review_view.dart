import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/features/home/presentation/manager/review_cubit/review_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/reviews_view/widgets/review_list.dart';
import 'package:coffee_app/features/home/presentation/view/reviews_view/widgets/review_list_loading.dart';
import 'package:coffee_app/features/home/presentation/view/reviews_view/widgets/review_overlay.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewView extends StatefulWidget {
  final int productId;
  const ReviewView({super.key, required this.productId});

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  late ReviewCubit _reviewCubit;

  @override
  void initState() {
    super.initState();
    _reviewCubit = context.read<ReviewCubit>();
    _reviewCubit.getReviews(widget.productId);
    _reviewCubit.listenToReviews(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: BlocConsumer<ReviewCubit, ReviewState>(
        listener: (context, state) {
          if (state is ReviewSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  S.current.reviewSubmittedSuccessfully,
                ), // Add this to your l10n
                backgroundColor: context.colors.primary,
              ),
            );
            // Reviews will update automatically via subscription
          }

          if (state is ReviewFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: context.colors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          Widget content;

          if (state is ReviewLoading) {
            content = const Expanded(child: ReviewListLoading());
          } else if (state is ReviewSuccess) {
            content = state.reviews.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        S.current.noReviewsYet,
                        style: TextStyles.regular16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Expanded(child: ReviewList(reviews: state.reviews));
          } else if (state is ReviewFailure) {
            content = Expanded(
              child: Center(
                child: Text(
                  state.error,
                  style: TextStyles.regular16.copyWith(
                    color: context.colors.error,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            content = const Expanded(child: SizedBox.shrink());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              content,
              const SizedBox(height: 12),
              CustomElevatedButton(
                onPressed: () =>
                    reviewOverlay(context, productId: widget.productId),
                child: Text(S.current.writeAReview, style: TextStyles.medium20),
              ),
            ],
          );
        },
      ),
    );
  }
}
