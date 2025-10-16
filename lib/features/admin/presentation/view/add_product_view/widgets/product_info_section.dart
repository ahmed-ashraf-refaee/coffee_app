import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/main.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:coffee_app/generated/l10n.dart';
import '../../../../../../core/model/categories_model.dart';

class ProductInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController discountController;
  final List<CategoriesModel> categories;
  final CategoriesModel? selectedCategory;
  final Function(CategoriesModel?) onCategoryChanged;
  final String? Function(String?, String) requiredValidator;

  const ProductInfoSection({
    super.key,
    required this.nameController,
    required this.descController,
    required this.discountController,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.requiredValidator,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Column(
      spacing: 16,
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: l10n.productNameHint,
            prefixIcon: const Icon(Ionicons.cube_outline),
          ),
          validator: (v) => requiredValidator(v, l10n.productNameLabel),
        ),
        TextFormField(
          controller: descController,
          decoration: InputDecoration(
            hintText: l10n.productDescriptionHint,
            prefixIcon: const Icon(Ionicons.document_text_outline),
          ),
          validator: (v) => requiredValidator(v, l10n.productDescriptionLabel),
        ),

        DropdownButtonFormField2<CategoriesModel>(
          value: selectedCategory,
          isExpanded: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Ionicons.list_outline),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
          hint: Text(
            textAlign: TextAlign.start,
            l10n.productCategoryHint,
            style: TextStyles.medium16.copyWith(
              color: context.colors.onSecondary.withValues(alpha: 0.6),
            ),
          ),
          items: categories.map((cat) {
            return DropdownMenuItem(
              value: cat,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        cat.name,
                        style: TextStyles.medium16.copyWith(
                          color: context.colors.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          selectedItemBuilder: (context) {
            return categories.map((cat) {
              // 👇 this is the key: controls padding for the *selected item only*
              return Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    cat.name,
                    style: TextStyles.medium16.copyWith(
                      color: context.colors.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              );
            }).toList();
          },
          onChanged: onCategoryChanged,
          validator: (value) =>
              value == null ? l10n.productCategoryError : null,
          dropdownStyleData: DropdownStyleData(
            offset: const Offset(0, -16),
            maxHeight: 300,
            elevation: 0,
            decoration: BoxDecoration(
              color: context.colors.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: 0),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Ionicons.chevron_down,
              color: context.colors.onSecondary,
            ),
          ),
        ),

        TextFormField(
          controller: discountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          maxLength: 2,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.productDiscountHint,
            prefixIcon: const Icon(Ionicons.pricetag_outline),
          ),
        ),
      ],
    );
  }
}
