import 'package:coffee_app/features/home/presentation/view/home_view/widgets/home_app_bar.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/products_grid.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/search_bar.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/search_delegate.dart';
import 'package:flutter/material.dart' hide SearchDelegate, SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manager/home_filter_cubit/home_filter_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    searchController = TextEditingController(
      text: context.read<HomeFilterCubit>().selectedQuery,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.only(top: 16),
          sliver: HomeAppBar(),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: SearchDelegate(
            maxHeight: 128,
            minHeight: 128,
            child: SearchBar(searchController: searchController),
          ),
        ),

        const ProductsGrid(),
      ],
    );
  }
}
