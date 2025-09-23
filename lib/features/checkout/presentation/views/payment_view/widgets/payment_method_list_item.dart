import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class PaymentMethodListItem extends StatelessWidget {
  const PaymentMethodListItem({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.cardHolderName,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
  });

  final bool selected;
  final VoidCallback onSelected;
  final String cardHolderName;
  final String last4;
  final String expiryMonth;
  final String expiryYear;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onSelected,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected ? context.colors.primary : context.colors.secondary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardHolderName,
                    style: TextStyle(
                      color: selected
                          ? context.colors.onPrimary
                          : context.colors.onSecondary,
                    ),
                  ),
                  Text(
                    "**** **** **** $last4",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: selected
                          ? context.colors.onPrimary
                          : context.colors.onSecondary,
                    ),
                  ),
                ],
              ),
              Text(
                '$expiryMonth/${expiryYear.substring(expiryYear.length - 2)}',
                style: TextStyle(
                  color: selected
                      ? context.colors.onPrimary
                      : context.colors.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
