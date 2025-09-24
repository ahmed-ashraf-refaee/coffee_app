import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';

Widget cardBrandIcon({
  required BuildContext context,
  required String? brand,
  required bool selected,
  required double size,
}) {
  switch (brand?.toLowerCase()) {
    case 'visa':
      return Icon(
        SimpleIcons.visa,
        color: selected ? context.colors.onPrimary : context.colors.onSecondary,
        size: size,
      );
    case 'mastercard':
      return Icon(
        SimpleIcons.mastercard,
        color: selected ? context.colors.onPrimary : context.colors.onSecondary,
        size: size,
      );
    case 'amex':
    case 'american express':
      return Icon(
        SimpleIcons.americanexpress,
        color: selected ? context.colors.onPrimary : context.colors.onSecondary,
        size: size,
      );
    case 'discover':
      return Icon(
        SimpleIcons.discover,
        color: selected ? context.colors.onPrimary : context.colors.onSecondary,
        size: size,
      );
    case 'diners':
    case 'diners club':
      return Icon(
        SimpleIcons.dinersclub,
        color: selected ? context.colors.onPrimary : context.colors.onSecondary,
        size: size,
      );
    case 'jcb':
      return Icon(
        SimpleIcons.jcb,
        color: selected ? context.colors.onPrimary : context.colors.onSecondary,
        size: size,
      );
    default:
      return Icon(
        Icons.credit_card,
        color: selected ? context.colors.onPrimary : context.colors.onSecondary,
        size: size,
      );
  }
}
