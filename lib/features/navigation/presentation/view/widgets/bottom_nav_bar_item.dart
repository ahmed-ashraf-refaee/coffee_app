import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/navigation/presentation/view/widgets/custom_bottom_nav_bar.dart';
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
  final Pair<IconData, IconData> icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: PrettierTap(
        onPressed: onPressed,
        shrink: 4,
        child: Container(
          color: Colors.transparent,

          height: 32,
          width: 32,

          child: Column(
            children: [
              Icon(
                isSelected ? icon.b : icon.a,
                size: 24,
                color: isSelected
                    ? context.colors.primary
                    : context.colors.onSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
