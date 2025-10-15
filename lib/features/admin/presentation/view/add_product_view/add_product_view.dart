import 'dart:io';
import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/widgets/title_subtitle.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/model/categories_model.dart';
import '../../../../../core/model/product_model.dart';
import '../../../../../core/model/product_variants_model.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../manager/admin_product_manager/admin_product_manager_cubit.dart';
import 'widgets/add_product_app_bar.dart';
import 'widgets/add_variation_button.dart';
import 'widgets/product_image_picker.dart';
import 'widgets/product_info_section.dart';
import 'widgets/variations_section.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _discountController = TextEditingController();

  final picker = ImagePicker();
  File? _selectedImage;
  CategoriesModel? _selectedCategory;

  final List<CategoriesModel> _categories = [
    CategoriesModel(id: 1, name: 'Hot Beverages'),
    CategoriesModel(id: 2, name: 'Cold Beverages'),
    CategoriesModel(id: 3, name: 'Pastries'),
    CategoriesModel(id: 4, name: 'Tea and Infusions'),
    CategoriesModel(id: 5, name: 'Light Meals'),
    CategoriesModel(id: 6, name: 'Desserts'),
  ];

  final List<Variant> _variants = [Variant()];

  String? _requiredValidator(String? value, String field) {
    if (value == null || value.trim().isEmpty) return "$field ${S.current.isRequired}";
    return null;
  }

  String? _doubleValidator(String? value, String field, {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      if (required) return "$field ${S.current.isRequired}";
      return null;
    }
    final val = double.tryParse(value);
    if (val == null) return "$field ${S.current.mustBeNumber}";
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
        SnackBar(content: Text(S.current.maxVariantsReached)),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.current.imageRequired)),
      );
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.current.categoryRequired)),
      );
      return;
    }

    final productVariants = _variants.map((v) {
      return ProductVariantsModel(
        id: 0,
        size: v.sizeController.text.trim(),
        price: double.tryParse(v.priceController.text) ?? 0.0,
        quantity: int.tryParse(v.quantityController.text) ?? 0,
        productId: 0,
      );
    }).toList();
    final product = ProductModel(
      id: 0,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      discount: double.tryParse(_discountController.text) ?? 0,
      categoryId: _selectedCategory!.id,
      imageUrl: _selectedImage!.path,
      rating: 0,
      numberOfRatings: 0,
      createdAt: DateTime.now(),
      productVariants: productVariants,
      category: null,
    );

    context.read<AdminProductManagerCubit>().createProduct(product);
    _clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
                      TitleSubtitle(
                        title: S.current.addProductTitle,
                        subtitle: S.current.addProductSubtitle,
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
                      BlocConsumer<AdminProductManagerCubit, AdminProductManagerState>(
                        listener: (context, state) {
                          if (state is AdminProductFailure) {
                            UiHelpers.showSnackBar(
                              context: context,
                              message: state.error,
                            );
                          } else if (state is AdminProductSuccess) {
                            UiHelpers.showSnackBar(
                              context: context,
                              message: S.current.productAddedSuccessfully,
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomElevatedButton(
                            isLoading: state is AdminProductLoading,
                            onPressed: _submitForm,
                            child: Text(
                              S.current.addProductButton,
                              style: TextStyles.medium20,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Variant {
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
}
