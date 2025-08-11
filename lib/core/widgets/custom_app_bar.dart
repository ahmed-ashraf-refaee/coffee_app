import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key, this.left, this.right})
    : assert(
        left != null || right != null,
        'Either left or right must be provided',
      );
  final Widget? left;
  final Widget? right;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            if (left != null) left!,
            const Spacer(),
            if (right != null) right!,
          ],
        ),
      ),
    );
  }
}
