import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class PaymentMethodListItem extends StatelessWidget {
  const PaymentMethodListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.secondary,
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 16,
              children: [
                Text("Card Holder Name"),
                Text("**** **** **** 4242", textDirection: TextDirection.ltr),
              ],
            ),
            Text('8/30'),
          ],
        ),
      ),
    );
  }
}
