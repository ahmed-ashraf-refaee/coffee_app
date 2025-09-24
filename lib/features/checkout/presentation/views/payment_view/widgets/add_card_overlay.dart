import 'package:coffee_app/core/constants/reg_constants.dart';
import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/overlay_container.dart';
import 'package:coffee_app/features/authentication/data/services/auth_service.dart';
import 'package:coffee_app/features/checkout/data/service/payment_method_service.dart';
import 'package:coffee_app/features/checkout/presentation/manager/payment/payment_cubit.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ionicons/ionicons.dart';

addCardOverlay(BuildContext context) =>
    UiHelpers.showOverlay(context: context, child: const AddCardOverlay());

class AddCardOverlay extends StatefulWidget {
  const AddCardOverlay({super.key});

  @override
  State<AddCardOverlay> createState() => _AddCardOverlayState();
}

class _AddCardOverlayState extends State<AddCardOverlay> {
  TextEditingController holderNameController = TextEditingController();
  @override
  void dispose() {
    holderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Padding(
        padding: const EdgeInsetsGeometry.all(16),
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: holderNameController,
              decoration: InputDecoration(
                hintText: S.current.holderName,
                prefixIcon: const Icon(Ionicons.person_outline),
              ),
              autovalidateMode: AutovalidateMode.onUnfocus,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return S.current.enterFirstName;
                } else if (value.trim().length < 3) {
                  return S.current.tooShort;
                } else if (!RegConstants.nameRegExp.hasMatch(value.trim())) {
                  return S.current.invalidCharacters;
                }
                return null;
              },
            ),
            CardField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),

              onCardChanged: (card) {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: BlocConsumer<PaymentCubit, PaymentState>(
                listener: (BuildContext context, PaymentState state) {
                  if (state is CardAddedSuccess) {
                    Navigator.of(context).pop();
                    UiHelpers.showSnackBar(
                      context: context,
                      message: "Card Added Successfully",
                    );
                  } else if (state is PaymentFailure) {
                    if (!mounted) return;
                    UiHelpers.showSnackBar(
                      context: context,
                      message: state.error,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    isLoading: state is PaymentLoading,
                    height: 56,
                    contentPadding: const EdgeInsets.all(8),
                    onPressed: () async {
                      context.read<PaymentCubit>().addCard(
                        holderName: holderNameController.text,
                      );
                    },
                    child: Text(S.current.apply, style: TextStyles.bold16),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
