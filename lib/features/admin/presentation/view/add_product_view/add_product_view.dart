import 'dart:io';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/model/categories_model.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import 'widgets/add_product_app_bar.dart';
import 'widgets/add_variation_button.dart';
import 'widgets/product_image_picker.dart';
import 'widgets/product_info_section.dart';
import 'widgets/variations_section.dart';

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
  CategoriesModel? _selectedCategory;

  final List<CategoriesModel> _categories = [
    CategoriesModel(id: 1, name: 'Coffee'),
    CategoriesModel(id: 2, name: 'Tea'),
    CategoriesModel(id: 3, name: 'Snacks'),
    CategoriesModel(id: 4, name: 'Dessert'),
  ];

  final List<Variant> _variants = [Variant()];

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
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        children: [
          AddProductAppBar(onRefresh: _clearAll),
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
                    ProductImagePicker(
                      image: _selectedImage,
                      onPick: _pickImage,
                    ),
                    ProductInfoSection(
                      nameController: _nameController,
                      descController: _descriptionController,
                      discountController: _discountController,
                      categories: _categories,
                      selectedCategory: _selectedCategory,
                      onCategoryChanged: (val) =>
                          setState(() => _selectedCategory = val),
                      requiredValidator: _requiredValidator,
                    ),
                    VariantsSection(
                      variants: _variants,
                      removeVariant: _removeVariant,
                      requiredValidator: _requiredValidator,
                      doubleValidator: _doubleValidator,
                    ),
                    AddVariantButton(
                      show: _variants.length < 3,
                      onAdd: _addVariant,
                    ),
                    const SizedBox(height: 20),
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

class Variant {
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
}
