import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isSelected,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Column(
        children: [
          PrettierTap(
            shrink: 4,
            onPressed: onPressed,
            child: Icon(
              icon,
              size: 24,
              color: isSelected
                  ? context.colors.primary
                  : context.colors.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
