import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

Widget buildSuffixIconWithDivider(BuildContext context, Widget suffix) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 1,
        height: 38,
        color: context.colors.onSecondary.withAlpha(102),
      ),
      suffix,
    ],
  );
}
