import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/features/checkout/data/models/address_model.dart';
import 'package:coffee_app/features/checkout/presentation/views/address_view/widgets/address_list_item.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddressListItemLoading extends StatelessWidget {
  const AddressListItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: UiHelpers.customShimmer(context),
      child: AddressListItem(
        selected: false,
        onSelected: () {},
        address: AddressModel(
          id: -1,
          title: "Home",
          address: "10th of ramadan , second, sharqia, block 35",
          city: "10th of ramadan",
          phoneNumber: "01155005500",
          state: "sharkia",
        ),
      ),
    );
  }
}
