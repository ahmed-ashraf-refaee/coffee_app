import 'package:coffee_app/core/constants/reg_constants.dart';
import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/overlay_container.dart';
import 'package:coffee_app/features/checkout/presentation/manager/payment/payment_cubit.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
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
  final TextEditingController holderNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<CardFieldInputDetails?> _card = ValueNotifier(null);
  final ValueNotifier<String?> _cardErrorText = ValueNotifier(null);
  bool _validationAttempted = false;

  @override
  void dispose() {
    holderNameController.dispose();
    _card.dispose();
    _cardErrorText.dispose();
    super.dispose();
  }

  void _validateCardField(CardFieldInputDetails? cardDetails) {
    if (!_validationAttempted) return;
    if (cardDetails == null || !cardDetails.complete) {
      _cardErrorText.value = S.current.enterCardDetails;
    } else {
      _cardErrorText.value = null;
    }
  }

  bool _validateAllFields() {
    _validationAttempted = true;
    _validateCardField(_card.value);
    final formIsValid = _formKey.currentState?.validate() ?? false;
    return formIsValid && _cardErrorText.value == null;
  }

  @override
  Widget build(BuildContext context) {
    return OverlayContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
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
                  } else if (!RegConstants.cardHolderNameRegExp.hasMatch(
                    value.trim(),
                  )) {
                    return S.current.invalidCharacters;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ValidatedCardField(
                cardNotifier: _card,
                errorNotifier: _cardErrorText,
                validateCardField: _validateCardField,
              ),
              const SizedBox(height: 32),
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
                    } else if (state is PaymentCardOverlayFailure) {
                      if (!mounted) return;
                      UiHelpers.showSnackBar(
                        context: context,
                        message: state.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      isLoading: state is PaymentCardOverlayLoading,
                      height: 56,
                      contentPadding: const EdgeInsets.all(8),
                      onPressed: () async {
                        if (_validateAllFields()) {
                          context.read<PaymentCubit>().addCard(
                            holderName: holderNameController.text.trim(),
                          );
                        }
                      },
                      child: Text(S.current.apply, style: TextStyles.bold16),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ValidatedCardField extends StatelessWidget {
  final ValueNotifier<CardFieldInputDetails?> cardNotifier;
  final ValueNotifier<String?> errorNotifier;
  final void Function(CardFieldInputDetails?) validateCardField;

  const ValidatedCardField({
    super.key,
    required this.cardNotifier,
    required this.errorNotifier,
    required this.validateCardField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          onCardChanged: (card) {
            cardNotifier.value = card;
            validateCardField(card);
          },
        ),
        ValueListenableBuilder<String?>(
          valueListenable: errorNotifier,
          builder: (context, error, child) {
            return AnimatedSize(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: error == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Align(
                        alignment: context.isArabic
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Text(
                          error,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}
