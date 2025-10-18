import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class SummaryLine extends StatefulWidget {
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
  State<SummaryLine> createState() => _SummaryLineState();
}

class _SummaryLineState extends State<SummaryLine> {
  double _oldValue = 0;
  double _newValue = 0;

  double _parseValue(String val) {
    final cleaned = val.replaceAll(RegExp(r'[^0-9\.\-]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  @override
  void didUpdateWidget(covariant SummaryLine oldWidget) {
    super.didUpdateWidget(oldWidget);
    final parsed = _parseValue(widget.value);
    if (parsed != _newValue) {
      setState(() {
        _oldValue = _newValue;
        _newValue = parsed;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _newValue = _parseValue(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.label, style: widget.style),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: _oldValue, end: _newValue),
          duration: const Duration(milliseconds: 400),
          builder: (context, animatedValue, _) {
            return Text(
              "${animatedValue.toStringAsFixed(2)} ${S.current.egp}",
              style: widget.style,
            );
          },
        ),
      ],
    );
  }
}
