import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class SummaryLine extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle style;

  const SummaryLine({
    super.key,
    required this.label,
    required this.value,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text("$value ${S.current.egp}", style: style),
      ],
    );
  }
}
