import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/features/home/presentation/manager/home_filter_cubit/home_filter_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/categories_list.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/filter_overlay.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextField(
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: CustomIconButton(
                          onPressed: () {},
                          child: const Icon(Ionicons.search_outline),
                        ),
                        hintText: S.current.search,
                        prefixIconColor: context.colors.onSecondary,
                        hintStyle: TextStyles.medium16.copyWith(
                          color: context.colors.onSecondary,
                        ),
                      ),
                      onChanged: (value) {
                        context.read<HomeFilterCubit>().selectedQuery =
                            value;
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
                      return Icon(
                        Ionicons.filter,
                        color:
                            context.read<HomeFilterCubit>().isFiltered()
                            ? context.colors.primary
                            : context.colors.onSecondary,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const CategoriesList(),
        ],
      ),
    );
  }
}
