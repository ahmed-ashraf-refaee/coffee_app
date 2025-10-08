import 'dart:io';

import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../core/widgets/prettier_tap.dart';

// ──────────────────────── Category Model ────────────────────────
class Category {
  final String id;
  final String name;
  Category({required this.id, required this.name});
}

// ──────────────────────── Variant Model ────────────────────────
class Variant {
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
}

class AddProductViewBody extends StatefulWidget {
  const AddProductViewBody({super.key});

  @override
  State<AddProductViewBody> createState() => _AddProductViewBodyState();
}

class _AddProductViewBodyState extends State<AddProductViewBody> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _discountController = TextEditingController();

  final picker = ImagePicker();
  File? _selectedImage;

  final List<Category> _categories = [
    Category(id: '1', name: 'Coffee'),
    Category(id: '2', name: 'Tea'),
    Category(id: '3', name: 'Snacks'),
    Category(id: '4', name: 'Dessert'),
  ];
  Category? _selectedCategory;

  final List<Variant> _variants = [Variant()];

  //──────────────────────── Validation ────────────────────────
  String? _requiredValidator(String? value, String field) {
    if (value == null || value.trim().isEmpty) return "$field is required";
    return null;
  }

  String? _doubleValidator(
    String? value,
    String field, {
    bool required = true,
  }) {
    if (value == null || value.trim().isEmpty) {
      if (required) return "$field is required";
      return null;
    }
    final val = double.tryParse(value);
    if (val == null) return "$field must be a number";
    return null;
  }

  //──────────────────────── Actions ────────────────────────
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  void _addVariant() {
    if (_variants.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Maximum of 3 variants allowed")),
      );
      return;
    }
    setState(() => _variants.add(Variant()));
  }

  void _removeVariant(int index) => setState(() => _variants.removeAt(index));

  void _clearAll() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _descriptionController.clear();
    _discountController.clear();
    for (final v in _variants) {
      v.sizeController.clear();
      v.priceController.clear();
      v.quantityController.clear();
    }
    setState(() {
      _selectedImage = null;
      _selectedCategory = null;
      _variants
        ..clear()
        ..add(Variant());
    });
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an image")));
      return;
    }
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select a category")));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product added successfully!")),
    );

    _clearAll();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _discountController.dispose();
    for (final v in _variants) {
      v.sizeController.dispose();
      v.priceController.dispose();
      v.quantityController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16,
        children: [
          // ──────────────────────── Custom App Bar ────────────────────────
          CustomAppBar(
            leading: CustomIconButton(
              padding: 8,
              onPressed: () {},
              child: Icon(
                Ionicons.chevron_back,
                color: context.colors.onSecondary,
              ),
            ),
            trailing: CustomIconButton(
              padding: 8,
              onPressed: _clearAll,
              child: Icon(
                Ionicons.refresh_outline,
                color: context.colors.primary,
              ),
            ),
          ),

          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Product",
                      style: TextStyles.bold20.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),
                    Text(
                      "Add a new product to your store",
                      style: TextStyles.regular15.copyWith(
                        color: context.colors.onSecondary,
                      ),
                    ),

                    // ──────────────────────── Image Picker ────────────────────────
                    PrettierTap(
                      shrink: 1,
                      onPressed: _pickImage,
                      child: Container(
                        width: context.width,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: context.colors.secondary,
                        ),
                        child: _selectedImage == null
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
                                    "Upload product image (PNG)",
                                    style: TextStyles.regular15.copyWith(
                                      color: context.colors.onSecondary,
                                    ),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 180,
                                ),
                              ),
                      ),
                    ),

                    // ──────────────────────── Product Info ────────────────────────
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Product Name",
                        prefixIcon: Icon(Ionicons.cube_outline),
                      ),
                      validator: (v) => _requiredValidator(v, "Product name"),
                    ),

                    // Description single line
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: "Description",
                        prefixIcon: Icon(Ionicons.document_text_outline),
                      ),
                      minLines: 1,
                      maxLines: 1,
                      expands: false,
                      validator: (v) => _requiredValidator(v, "Description"),
                    ),

                    // ──────────────────────── Category Dropdown ────────────────────────
                    DropdownButtonFormField<Category>(
                      initialValue: _selectedCategory,
                      items: _categories
                          .map(
                            (cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(cat.name),
                            ),
                          )
                          .toList(),

                      onChanged: (value) =>
                          setState(() => _selectedCategory = value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Ionicons.list_outline),
                        hintText: "Select Category",

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                      ),
                      validator: (value) =>
                          value == null ? "Please select a category" : null,
                    ), // Discount optional
                    TextFormField(
                      controller: _discountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),

                      maxLength: 2,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        counterText: '',
                        hintText: "Discount (%) (optional)",
                        prefixIcon: Icon(Ionicons.pricetag_outline),
                      ),
                    ),

                    const Divider(height: 32),
                    Text(
                      "Variants",
                      style: TextStyles.bold20.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),

                    // ──────────────────────── Variants List ────────────────────────
                    ..._variants.asMap().entries.map((entry) {
                      final index = entry.key;
                      final variant = entry.value;
                      return Container(
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: context.colors.surface,
                          border: Border.all(
                            color: context.colors.outline.withValues(
                              alpha: 0.2,
                            ),
                          ),
                        ),
                        child: Column(
                          spacing: 16,
                          children: [
                            SizedBox(
                              height: 48,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Variant ${index + 1}",
                                    style: TextStyles.medium16,
                                  ),
                                  if (_variants.length > 1)
                                    CustomIconButton(
                                      onPressed: () => _removeVariant(index),
                                      backgroundColor: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Icon(
                                        Ionicons.trash_outline,
                                        color: context.colors.primary,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            TextFormField(
                              controller: variant.sizeController,
                              decoration: const InputDecoration(
                                hintText: "Size (e.g. Small, Medium)",
                                prefixIcon: Icon(Ionicons.resize_outline),
                              ),
                              validator: (v) => _requiredValidator(v, "Size"),
                            ),
                            TextFormField(
                              controller: variant.priceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: const InputDecoration(
                                hintText: "Price (e.g. 9.99)",
                                prefixIcon: Icon(Ionicons.cash_outline),
                              ),
                              validator: (v) => _doubleValidator(v, "Price"),
                            ),
                            TextFormField(
                              controller: variant.quantityController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Quantity (in stock)",
                                prefixIcon: Icon(Ionicons.cube_outline),
                              ),
                              validator: (v) => _doubleValidator(v, "Quantity"),
                            ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 10),

                    if (_variants.length < 3)
                      Align(
                        alignment: Alignment.centerRight,
                        child: PrettierTap(
                          onPressed: _addVariant,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Ionicons.add_circle_outline),
                              const SizedBox(width: 6),
                              Text(
                                "Add another variant",
                                style: TextStyles.medium16.copyWith(
                                  color: context.colors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    // ──────────────────────── Save Button ────────────────────────
                    CustomElevatedButton(
                      onPressed: _submitForm,
                      child: const Text(
                        "Add Product",
                        style: TextStyles.medium20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
