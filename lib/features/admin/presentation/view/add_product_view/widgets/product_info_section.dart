import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

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
    return Column(
      spacing: 16,
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: "Product Name",
            prefixIcon: Icon(Ionicons.cube_outline),
          ),
          validator: (v) => requiredValidator(v, "Product name"),
        ),
        TextFormField(
          controller: descController,
          decoration: const InputDecoration(
            hintText: "Description",
            prefixIcon: Icon(Ionicons.document_text_outline),
          ),
          validator: (v) => requiredValidator(v, "Description"),
        ),
        DropdownButtonFormField<CategoriesModel>(
          initialValue: selectedCategory,
          items: categories
              .map((cat) => DropdownMenuItem(value: cat, child: Text(cat.name)))
              .toList(),
          onChanged: onCategoryChanged,
          decoration: const InputDecoration(
            prefixIcon: Icon(Ionicons.list_outline),
            hintText: "Select Category",
          ),
          validator: (value) =>
              value == null ? "Please select a category" : null,
        ),
        TextFormField(
          controller: discountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          maxLength: 2,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            counterText: '',
            hintText: "Discount (%) (optional)",
            prefixIcon: Icon(Ionicons.pricetag_outline),
          ),
        ),
      ],
    );
  }
}
