import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/overlay_container.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/home/presentation/manager/home_filter_cubit/home_filter_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/details_view/widgets/custom_chip.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/filter_constants.dart';
import '../../../../../../core/helper/ui_helpers.dart';

TextEditingController minPriceController = TextEditingController();
TextEditingController maxPriceController = TextEditingController();

void filterOverlay(BuildContext context) => UiHelpers.showOverlay(
  context: context,
  child: BlocProvider.value(
    value: context.read<HomeFilterCubit>(),
    child: const FilterOverlay(),
  ),
);

class FilterOverlay extends StatefulWidget {
  const FilterOverlay({super.key});

  @override
  State<FilterOverlay> createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {
  @override
  void initState() {
    super.initState();
    minPriceController.text = context
        .read<HomeFilterCubit>()
        .selectedPriceRange
        .start
        .toStringAsFixed(0);
    maxPriceController.text = context
        .read<HomeFilterCubit>()
        .selectedPriceRange
        .end
        .toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    void onApplyFilters() {
      context.read<HomeFilterCubit>().setFilters();
      Navigator.of(context).pop();
    }

    void onResetFilters() {
      minPriceController.text = FilterConstants.minPrice.toStringAsFixed(0);
      maxPriceController.text = FilterConstants.maxPrice.toStringAsFixed(0);
      context.read<HomeFilterCubit>().resetFilters();
    }

    return OverlayContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(height: 604),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.reset,
                    style: TextStyles.regular15.copyWith(
                      color: Colors.transparent,
                    ),
                  ),

                  Text(S.current.filters, style: TextStyles.bold20),

                  PrettierTap(
                    shrink: 1,
                    onPressed: onResetFilters,
                    child: Text(
                      S.current.reset,
                      style: TextStyles.regular15.copyWith(
                        color: context.colors.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),

              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 16,
                    children: [SortFilter(), PriceFilter(), RatingFilter()],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: CustomElevatedButton(
                  height: 56,
                  contentPadding: const EdgeInsets.all(8),
                  onPressed: onApplyFilters,
                  child: Text(
                    S.current.apply,
                    style: TextStyles.bold16.copyWith(
                      color: context.colors.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SortFilter extends StatefulWidget {
  const SortFilter({super.key});

  @override
  State<SortFilter> createState() => _SortFilterState();
}

class _SortFilterState extends State<SortFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.current.sortBy,
          style: TextStyles.regular15.copyWith(color: context.colors.onSurface),
        ),
        BlocBuilder<HomeFilterCubit, HomeFilterState>(
          builder: (context, state) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              direction: Axis.horizontal,
              children: FilterConstants.sortOptions
                  .map(
                    (label) => CustomChip(
                      label: label,
                      selected:
                          context.read<HomeFilterCubit>().selectedSort == label,
                      onSelected: () {
                        setState(() {
                          if (context.read<HomeFilterCubit>().selectedSort ==
                              label) {
                            context.read<HomeFilterCubit>().selectedSort = '';
                          } else {
                            context.read<HomeFilterCubit>().selectedSort =
                                label;
                          }
                        });
                      },
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class PriceFilter extends StatefulWidget {
  const PriceFilter({super.key});

  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  void _updateRange(RangeValues range) {
    setState(() {
      double start = range.start.clamp(
        FilterConstants.minPrice,
        FilterConstants.maxPrice,
      );
      double end = range.end.clamp(
        FilterConstants.minPrice,
        FilterConstants.maxPrice,
      );

      if (start > end) start = end;

      context.read<HomeFilterCubit>().selectedPriceRange = RangeValues(
        start,
        end,
      );
      minPriceController.text = start.toStringAsFixed(0);
      maxPriceController.text = end.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.current.priceRange,
          style: TextStyles.regular15.copyWith(color: context.colors.onSurface),
        ),
        BlocBuilder<HomeFilterCubit, HomeFilterState>(
          builder: (context, state) {
            return RangeSlider(
              min: FilterConstants.minPrice,
              max: FilterConstants.maxPrice,
              values: context.read<HomeFilterCubit>().selectedPriceRange,
              inactiveColor: context.colors.secondary,
              onChanged: (rangeValues) => _updateRange(rangeValues),
            );
          },
        ),
        Row(
          spacing: 16,
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                ),
                controller: minPriceController,
                onChanged: (value) {
                  double min = safeDoubleParse(value).clamp(
                    FilterConstants.minPrice,
                    context.read<HomeFilterCubit>().selectedPriceRange.end,
                  );
                  _updateRange(
                    RangeValues(
                      min,
                      context.read<HomeFilterCubit>().selectedPriceRange.end,
                    ),
                  );
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(
              width: 32,
              child: Divider(color: context.colors.secondary, thickness: 4),
            ),
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                  ),
                  controller: maxPriceController,
                  onChanged: (value) {
                    double max = safeDoubleParse(value).clamp(
                      context.read<HomeFilterCubit>().selectedPriceRange.start,
                      FilterConstants.maxPrice,
                    );
                    _updateRange(
                      RangeValues(
                        context
                            .read<HomeFilterCubit>()
                            .selectedPriceRange
                            .start,
                        max,
                      ),
                    );
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RatingFilter extends StatefulWidget {
  const RatingFilter({super.key});

  @override
  State<RatingFilter> createState() => _RatingFilterState();
}

class _RatingFilterState extends State<RatingFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          S.current.rating,
          style: TextStyles.regular15.copyWith(color: context.colors.onSurface),
        ),
        BlocBuilder<HomeFilterCubit, HomeFilterState>(
          builder: (context, state) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              direction: Axis.horizontal,
              children: FilterConstants.ratingOptions
                  .map(
                    (label) => CustomChip(
                      label: label,
                      selected:
                          context.read<HomeFilterCubit>().selectedRating ==
                          label,
                      onSelected: () {
                        setState(() {
                          if (context.read<HomeFilterCubit>().selectedRating ==
                              label) {
                            context.read<HomeFilterCubit>().selectedRating = '';
                          } else {
                            context.read<HomeFilterCubit>().selectedRating =
                                label;
                          }
                        });
                      },
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

double safeDoubleParse(String value) {
  final double? parsedValue = double.tryParse(value);
  return parsedValue ?? 0;
}
