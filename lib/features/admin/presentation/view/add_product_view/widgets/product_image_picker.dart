import 'dart:io';

import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/prettier_tap.dart';

class ProductImagePicker extends StatelessWidget {
  final File? image;
  final VoidCallback onPick;

  const ProductImagePicker({
    super.key,
    required this.image,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return PrettierTap(
      shrink: 1,
      onPressed: onPick,
      child: Container(
        width: context.width,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colors.secondary,
        ),
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.image_outline,
                    size: 50,
                    color: context.colors.onSecondary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    S.current.uploadProductImage,
                    style: TextStyles.regular15.copyWith(
                      color: context.colors.onSecondary,
                    ),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
      ),
    );
  }
}
