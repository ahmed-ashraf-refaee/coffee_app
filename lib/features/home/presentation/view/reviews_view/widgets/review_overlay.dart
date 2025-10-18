import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/overlay_container.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/home/presentation/manager/review_cubit/review_cubit.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../../core/helper/ui_helpers.dart';

void reviewOverlay(BuildContext context, {required int productId}) =>
    UiHelpers.showOverlay(
      context: context,
      child: ReviewOverlay(productId: productId),
    );

class ReviewOverlay extends StatefulWidget {
  final int productId;
  const ReviewOverlay({super.key, required this.productId});

  @override
  State<ReviewOverlay> createState() => _ReviewOverlayState();
}

class _ReviewOverlayState extends State<ReviewOverlay> {
  final TextEditingController reviewController = TextEditingController();
  double rating = 5;

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  void onSendReview() {
    context.read<ReviewCubit>().submitReview(
      productId: widget.productId,
      userId: Supabase.instance.client.auth.currentSession!.user.id,
      rating: rating,
      comment: reviewController.text,
    );
    context.read<ReviewCubit>().getReviews(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is ReviewFailure) {
          UiHelpers.showSnackBar(context: context, message: state.error);
        } else if (state is ReviewSubmitted) {
          Navigator.of(context).pop();
          UiHelpers.showSnackBar(
            context: context,
            message: S.current.reviewSubmittedSuccessfully,
          );
        }
      },
      child: OverlayContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 386),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.cancel,
                      style: TextStyles.regular15.copyWith(
                        color: Colors.transparent,
                      ),
                    ),
                    Text(S.current.leaveReview, style: TextStyles.bold20),
                    PrettierTap(
                      shrink: 1,
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        S.current.cancel,
                        style: TextStyles.regular15.copyWith(
                          color: context.colors.onSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 24,
                      children: [
                        _RatingSelector(
                          rating: rating,
                          onChanged: (val) => setState(() => rating = val),
                        ),
                        TextField(
                          controller: reviewController,
                          maxLines: 7,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: S.current.writeReviewHint,
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          style: TextStyles.regular15.copyWith(
                            color: context.colors.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: BlocBuilder<ReviewCubit, ReviewState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        isLoading: state is ReviewSubmitting,
                        height: 56,
                        contentPadding: const EdgeInsets.all(8),
                        onPressed: onSendReview,
                        child: Text(S.current.submit, style: TextStyles.bold16),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RatingSelector extends StatelessWidget {
  final double rating;
  final Function(double) onChanged;

  const _RatingSelector({required this.rating, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isRtl = context.isArabic;

    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final filled = rating >= starIndex;
        final halfFilled = rating >= (starIndex - 0.5) && rating < starIndex;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) {
            final localX = details.localPosition.dx;
            final isHalf = isRtl
                ? localX >
                      16 // right half in RTL
                : localX < 16; // left half in LTR
            final newRating = starIndex - (isHalf ? 0.5 : 0.0);
            onChanged(newRating);
          },
          child: Transform.flip(
            flipX: halfFilled,
            child: Icon(
              filled
                  ? Ionicons.star
                  : halfFilled
                  ? Ionicons.star_half
                  : Ionicons.star_outline,
              size: 32,
              color: context.colors.primary,
            ),
          ),
        );
      }),
    );
  }
}
