import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'text_styles.dart';

ThemeData appTheme = ThemeData().copyWith(
  scaffoldBackgroundColor: ColorPalette.eerieBlack,
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).apply(
    bodyColor: ColorPalette.antiFlashWhite,
    displayColor: ColorPalette.antiFlashWhite,
    decorationColor: ColorPalette.antiFlashWhite,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: ColorPalette.antiFlashWhite,
      backgroundColor: ColorPalette.orangeCrayola,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      textStyle: TextStyles.medium20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ColorPalette.raisinBlack,
    hintStyle: TextStyles.bold16.copyWith(
      color: ColorPalette.cadetGray.withAlpha(102),
    ),
    suffixIconColor: ColorPalette.cadetGray.withAlpha(153),
    prefixIconColor: ColorPalette.cadetGray.withAlpha(102),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 24),
  ),
);
