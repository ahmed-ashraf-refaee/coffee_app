import 'dart:ui';

import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UiHelpers {
  static void showSnackBar({
    required BuildContext context,
    required String message,
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
        backgroundColor: context.colors.surface,
        duration: const Duration(seconds: 3),
        elevation: 1,
      ),
    );
  }

  static Future<void> showAlert({
    required BuildContext context,
    required Widget content,
    String? title,
    required List<Widget> actions,
    double blurSigma = 3.0,
  }) {
    assert(actions.length <= 2);

    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (_, __, ___) {
          return _BlurredBackground(
            context: context,
            blurSigma: blurSigma,
            child: AlertDialog(
              title: title != null
                  ? Text(
                      title,
                      style: TextStyles.bold16.copyWith(
                        color: context.colors.onSurface,
                      ),
                    )
                  : null,
              content: content,
              contentTextStyle: TextStyles.regular16.copyWith(
                color: context.colors.onSecondary,
              ),
              elevation: 0,
              actions: actions,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: context.colors.surface,
            ),
          );
        },
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
    double blurSigma = 3.0,
    VoidCallback? onDismiss,
  }) {
    return Navigator.of(context)
        .push(
          PageRouteBuilder(
            opaque: false,
            barrierColor: Colors.transparent,
            pageBuilder: (_, __, ___) {
              return _BlurredBackground(
                context: context,
                blurSigma: blurSigma,
                child: GestureDetector(onTap: () {}, child: child),
              );
            },
          ),
        )
        .then((_) {
          if (onDismiss != null) {
            onDismiss();
          }
        });
  }
}

class _BlurredBackground extends StatelessWidget {
  final BuildContext context;
  final Widget child;
  final double blurSigma;

  const _BlurredBackground({
    required this.context,
    required this.child,
    this.blurSigma = 3.0,
  });

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Container(
                color: Color.lerp(
                  context.colors.surface,
                  Colors.black,
                  0.4,
                )!.withValues(alpha: 0.7),
              ),
            ),
          ),
          Center(child: child),
        ],
      ),
    );
  }
}
