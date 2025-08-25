import 'package:coffee_app/core/utils/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'text_styles.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: light,
  scaffoldBackgroundColor: light.surface,
  dividerTheme: DividerThemeData(color: light.onSecondary.withAlpha(102)),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return BorderSide(color: light.primary, width: 2);
      }
      return BorderSide(color: light.onSecondary, width: 1);
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return light.primary;
      }
      return Colors.transparent;
    }),
    checkColor: WidgetStateProperty.all(light.onPrimary),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: light.primary),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: light.primary,
    selectionColor: light.primary.withAlpha(102),
    selectionHandleColor: light.primary,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).apply(
    bodyColor: light.onSurface,
    displayColor: light.onSurface,
    decorationColor: light.onSurface,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: light.onPrimary,
      backgroundColor: light.primary,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 24),
      textStyle: TextStyles.medium20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: light.secondary,
    suffixIconColor: light.onSecondary.withAlpha(153),
    prefixIconColor: light.onSecondary.withAlpha(102),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyles.bold16.copyWith(
      color: light.onSecondary.withAlpha(102),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return light.onPrimary;
      }
      return light.onSecondary;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return light.primary;
      }
      return light.secondary;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return light.primary;
      }
      return light.onSecondary;
    }),
  ),
);
