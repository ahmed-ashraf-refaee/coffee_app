import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class AnalysisConstants {
  static List<String> get monthOptions => [
    S.current.month_jan,
    S.current.month_feb,
    S.current.month_mar,
    S.current.month_apr,
    S.current.month_may,
    S.current.month_jun,
    S.current.month_jul,
    S.current.month_aug,
    S.current.month_sep,
    S.current.month_oct,
    S.current.month_nov,
    S.current.month_dec,
  ];

  static List<Color> colors(BuildContext context) => [
    context.colors.primary,
    const Color(0xFF1F3E74),
    const Color(0xFF3A8662),
    const Color(0xFF6C2479),
    const Color(0xFF4E4E4E),
  ];
}
