import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UiHelpers {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyles.regular15.copyWith(color: context.colors.onSurface),
        ),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
        action: action,
        backgroundColor: context.colors.surface,
        duration: const Duration(seconds: 3),
        elevation: 1,
      ),
    );
  }

  static ShimmerEffect customShimmer(BuildContext context) => ShimmerEffect(
    baseColor: context.colors.onSecondary.withAlpha(5),
    highlightColor: context.colors.onSecondary.withAlpha(30),
  );
  static Future<void> showOverlay({
    required BuildContext context,
    required Widget child,
    Color backgroundColor = const Color.fromRGBO(0, 0, 0, 0.9),
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (_, __, ___) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: Center(child: child),
            ),
          );
        },
      ),
    );
  }
}
