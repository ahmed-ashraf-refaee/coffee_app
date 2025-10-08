import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../home/presentation/manager/home_filter_cubit/home_filter_cubit.dart';
import '../../../../../home/presentation/view/home_view/widgets/filter_overlay.dart';

class SearchAndFilterSection extends StatelessWidget {
  final TextEditingController searchController;

  const SearchAndFilterSection({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: TextField(
              onSubmitted: (value) {
                // You might want to trigger a final search or close keyboard here
              },
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: CustomIconButton(
                  onPressed: () {
                    // This could re-run the search on press, or clear the text
                    // For now, it doesn't need to do anything specific if the text changes are already handled
                  },
                  child: const Icon(Ionicons.search_outline),
                ),
                hintText: S.current.search,
                prefixIconColor: context.colors.onSecondary,
                hintStyle: TextStyles.medium16.copyWith(
                  color: context.colors.onSecondary,
                ),
              ),
              onChanged: (value) {
                // Update the search query and trigger a search/filter update
                context.read<HomeFilterCubit>().selectedQuery = value;
                context.read<HomeFilterCubit>().setSearch();
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        CustomIconButton(
          onPressed: () {
            filterOverlay(context);
          },
          hight: 48,
          width: 48,
          child: BlocBuilder<HomeFilterCubit, HomeFilterState>(
            builder: (context, state) {
              // Icon changes color based on whether a filter is active
              return Icon(
                Ionicons.filter,
                color: context.read<HomeFilterCubit>().isFiltered()
                    ? context.colors.primary
                    : context.colors.onSecondary,
              );
            },
          ),
        ),
      ],
    );
  }
}
