import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/title_subtitle.dart';
import 'package:coffee_app/features/checkout/presentation/manager/address/address_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/manager/address/address_state.dart';
import 'package:coffee_app/features/checkout/presentation/manager/card/card_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/views/address_view/widgets/address_list_item.dart';
import 'package:coffee_app/features/checkout/presentation/views/address_view/widgets/address_list_item_loading.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {
    final tr = S.of(context);
    final cardCubit = context.watch<CardCubit>();

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleSubtitle(
          title: tr.savedAddresses,
          subtitle: tr.savedAddressesSubtitle,
        ),
        BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state is AddressLoading) {
              return const Column(
                spacing: 16,
                children: [AddressListItemLoading(), AddressListItemLoading()],
              );
            } else if (state is AddressError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyles.medium16.copyWith(
                    color: context.colors.error,
                  ),
                ),
              );
            } else if (state is AddressLoaded) {
              final addressesList = state.addresses;
              if (addressesList.isEmpty) {
                return Text(
                  tr.noAddressesAvailable,
                  style: TextStyles.medium16,
                  textAlign: TextAlign.center,
                );
              }
              return Column(
                children: addressesList.map((address) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: AddressListItem(
                      address: address,
                      selected:
                          cardCubit.state.defaultAddress != null &&
                          address.id == cardCubit.state.defaultAddress!.id,
                      onSelected: () {
                        cardCubit.updateDefaultAddress(address);
                        GoRouter.of(context).pop();
                      },
                    ),
                  );
                }).toList(),
              );
            } else {
              return Text(
                tr.somethingWentWrong,
                style: TextStyles.medium16.copyWith(
                  color: context.colors.error,
                ),
                textAlign: TextAlign.center,
              );
            }
          },
        ),
        CustomElevatedButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kAddAddressView);
          },
          backgroundColor: context.colors.secondary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              Text(tr.addAddress, style: TextStyles.medium20),
              const Icon(Ionicons.add),
            ],
          ),
        ),
      ],
    );
  }
}
