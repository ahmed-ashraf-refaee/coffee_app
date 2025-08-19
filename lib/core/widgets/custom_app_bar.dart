import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.leading, this.trailing, this.padding = 0})
    : assert(
        leading != null || trailing != null,
        'Either left or right must be provided',
      );
  final Widget? leading;
  final Widget? trailing;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        mainAxisSize: MainAxisSize.max,

        children: [
          if (leading != null) leading!,
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
