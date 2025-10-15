import 'package:coffee_app/core/utils/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'text_styles.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: dark,
  scaffoldBackgroundColor: dark.surface,
  dividerTheme: DividerThemeData(
    color: dark.onSecondary.withValues(alpha: 0.4),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return BorderSide(color: dark.primary, width: 2);
      }
      return BorderSide(color: dark.onSecondary, width: 1);
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return dark.primary;
      }
      return Colors.transparent;
    }),
    checkColor: WidgetStateProperty.all(dark.onPrimary),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: dark.primary),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: dark.primary,
    selectionColor: dark.primary.withValues(alpha: 0.4),
    selectionHandleColor: dark.primary,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).apply(
    bodyColor: dark.onSurface,
    displayColor: dark.onSurface,
    decorationColor: dark.onSurface,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: dark.onPrimary,
      backgroundColor: dark.primary,
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 24),
      textStyle: TextStyles.medium20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: dark.secondary,
    suffixIconColor: dark.onSecondary.withValues(alpha: 0.6),
    prefixIconColor: dark.onSecondary.withValues(alpha: 0.4),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyles.bold16.copyWith(
      color: dark.onSecondary.withValues(alpha: 0.4),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return dark.onPrimary;
      }
      return dark.onSecondary;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return dark.primary;
      }
      return dark.secondary;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return dark.primary;
      }
      return dark.onSecondary;
    }),
  ),
);
