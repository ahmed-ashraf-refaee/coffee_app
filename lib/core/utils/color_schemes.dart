import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:flutter/material.dart';

const ColorScheme dark = ColorScheme(
  brightness: Brightness.dark,
  primary: ColorPalette.orangeCrayola,
  onPrimary: ColorPalette.antiFlashWhite,
  secondary: ColorPalette.raisinBlack,
  onSecondary: ColorPalette.cadetGray,
  error: ColorPalette.orangeCrayola,
  onError: ColorPalette.antiFlashWhite,
  surface: ColorPalette.eerieBlack,
  onSurface: ColorPalette.antiFlashWhite,
);
const ColorScheme light = ColorScheme(
  brightness: Brightness.light,
  primary: ColorPalette.orangeCrayola,
  onPrimary: ColorPalette.platinum,
  secondary: ColorPalette.linen,
  onSecondary: ColorPalette.charcoalGray,
  error: ColorPalette.orangeCrayola,
  onError: ColorPalette.antiFlashWhite,
  surface: ColorPalette.platinum,
  onSurface: ColorPalette.eerieBlack,
);
