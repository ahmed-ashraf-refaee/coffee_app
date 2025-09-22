import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class ActionContainer extends StatelessWidget {
  const ActionContainer({
    super.key,
    required this.title,
    this.content,
    required this.defaultContent,
    required this.action,
    required this.defaultAction,
  });
  final Widget? content;
  final String title;
  final Widget defaultContent;
  final Widget action;
  final Widget defaultAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.secondary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyles.regular16),
                content != null ? action : defaultAction,
              ],
            ),
            const Divider(),
            content ??
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: defaultContent,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
