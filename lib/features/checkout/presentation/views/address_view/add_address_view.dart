import 'package:coffee_app/core/widgets/custom_container.dart';
import 'package:coffee_app/features/checkout/presentation/views/address_view/widgets/add_address_view_body.dart';
import 'package:flutter/material.dart';

class AddAddressView extends StatelessWidget {
  const AddAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: CustomContainer(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 16,
                vertical: 58,
              ),
              child: AddAddressViewBody(),
            ),
          ),
        ),
      ),
    );
  }
}
