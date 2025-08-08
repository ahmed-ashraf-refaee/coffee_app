import 'package:flutter/material.dart';

import '../../../../../core/utils/color_palette.dart';

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
          GestureDetector(
            onTap: onPressed,
            child: Icon(
              icon,
              size: 24,
              color: isSelected
                  ? ColorPalette.orangeCrayola
                  : ColorPalette.cadetGray,
            ),
          ),
        ],
      ),
    );
  }
}
