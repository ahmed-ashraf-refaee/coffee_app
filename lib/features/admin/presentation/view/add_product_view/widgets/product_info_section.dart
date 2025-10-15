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
        DropdownButtonFormField<CategoriesModel>(
          initialValue: selectedCategory,
          items: categories
              .map((cat) => DropdownMenuItem(value: cat, child: Text(cat.name)))
              .toList(),
          onChanged: onCategoryChanged,
          decoration: InputDecoration(
            prefixIcon: const Icon(Ionicons.list_outline),
            hintText: l10n.productCategoryHint,
          ),
          validator: (value) =>
              value == null ? l10n.productCategoryError : null,
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
