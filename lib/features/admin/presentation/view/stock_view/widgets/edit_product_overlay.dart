import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:coffee_app/features/admin/presentation/manager/admin_product_manager/admin_product_manager_cubit.dart';
import 'package:coffee_app/features/home/presentation/manager/home_products_cubit/home_product_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/core/widgets/overlay_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/helper/ui_helpers.dart';
import '../../../../../../core/model/product_model.dart';
import '../../../../../../core/model/product_variants_model.dart';
import 'package:coffee_app/generated/l10n.dart';

void editProductOverlay(BuildContext context, {required ProductModel product}) {
  UiHelpers.showOverlay(
    context: context,
    child: EditProductOverlay(product: product),
  );
}

class EditProductOverlay extends StatefulWidget {
  final ProductModel product;

  const EditProductOverlay({super.key, required this.product});

  @override
  State<EditProductOverlay> createState() => _EditProductOverlayState();
}

class _EditProductOverlayState extends State<EditProductOverlay> {
  late List<ProductVariantsModel> _variants;
  late List<ProductVariantsModel> _originalVariants;

  @override
  void initState() {
    super.initState();
    _variants = widget.product.productVariants.toList();
    _originalVariants = widget.product.productVariants.toList();
  }

  void _addVariant() {
    if (_variants.length < 3) {
      setState(() {
        _variants.add(
          ProductVariantsModel(
            id: DateTime.now().millisecondsSinceEpoch,
            size: '',
            price: 0,
            quantity: 0,
            productId: 0,
          ),
        );
      });
    }
  }

  void _removeVariant(int index) {
    if (_variants.length > 1) {
      setState(() {
        _variants.removeAt(index);
      });
    }
  }

  void _revertChanges() {
    setState(() {
      _variants = _originalVariants.map((v) => v).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.current;

    return OverlayContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(height: 540),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title + Revert
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrettierTap(
                    shrink: 1,
                    onPressed: () {},
                    child: Text(
                      l10n.revert,
                      style: TextStyles.bold14.copyWith(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Text(l10n.editVariationsTitle, style: TextStyles.bold20),
                  PrettierTap(
                    shrink: 1,
                    onPressed: _revertChanges,
                    child: Text(
                      l10n.revert,
                      style: TextStyles.bold14.copyWith(
                        color: context.colors.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 12,
                    children: [
                      ...List.generate(_variants.length, (index) {
                        final variant = _variants[index];
                        return _buildVariantCard(context, variant, index, l10n);
                      }),

                      if (_variants.length < 3)
                        PrettierTap(
                          onPressed: _addVariant,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              l10n.addVariant,
                              style: TextStyles.bold14.copyWith(
                                color: context.colors.primary,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Bottom button row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child:
                    BlocConsumer<
                      AdminProductManagerCubit,
                      AdminProductManagerState
                    >(
                      listener: (context, state) {
                        if (state is AdminProductSuccess) {
                          UiHelpers.showSnackBar(
                            context: context,
                            message: S.current.updateProduct,
                          );
                          context.read<HomeProductCubit>().getProducts();
                          Navigator.pop(context);
                        } else if (state is AdminProductFailure) {
                          UiHelpers.showSnackBar(
                            context: context,
                            message: state.error,
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomElevatedButton(
                          height: 52,
                          isLoading: state is AdminProductLoading,
                          contentPadding: const EdgeInsets.all(8),
                          onPressed: () {
                            context
                                .read<AdminProductManagerCubit>()
                                .updateProduct(
                                  widget.product.copyWith(
                                    productVariants: _variants,
                                  ),
                                );
                          },
                          child: Text(
                            l10n.updateProduct,
                            style: TextStyles.bold16,
                          ),
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVariantCard(
    BuildContext context,
    ProductVariantsModel variant,
    int index,
    S l10n,
  ) {
    final isLow = variant.quantity < 20 && variant.quantity > 0;
    final isOut = variant.quantity == 0;
    Color color = isOut
        ? ColorPalette.errorLuxurious
        : (isLow ? ColorPalette.orangeCrayola : ColorPalette.darkGreen);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${l10n.variantLabel} ${index + 1}',
                style: TextStyles.bold16.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
              if (_variants.length > 1)
                PrettierTap(
                  shrink: 1,
                  onPressed: () => _removeVariant(index),
                  child: Text(
                    l10n.remove,
                    style: TextStyles.bold14.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
                ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: l10n.variantSizeLabel,
                  initialValue: variant.size,
                  onChanged: (v) {
                    setState(() {
                      _variants[index] = _variants[index].copyWith(size: v);
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTextField(
                  label: l10n.variantPriceLabel,
                  initialValue: variant.price.toString(),
                  inputType: TextInputType.number,
                  onChanged: (v) {
                    final parsedPrice = double.tryParse(v) ?? 0;
                    setState(() {
                      _variants[index] = _variants[index].copyWith(
                        price: parsedPrice,
                      );
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTextField(
                  label: l10n.stockLabel,
                  initialValue: variant.quantity.toString(),
                  inputType: TextInputType.number,
                  onChanged: (v) {
                    final parsedQuantity = int.tryParse(v) ?? 0;
                    setState(() {
                      _variants[index] = _variants[index].copyWith(
                        quantity: parsedQuantity,
                      );
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            isOut
                ? l10n.productStatusOut
                : (isLow ? l10n.productStatusLow : l10n.productStatusInStock),
            style: TextStyles.regular12.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required ValueChanged<String> onChanged,
    TextInputType inputType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.bold14.copyWith(color: context.colors.onSecondary),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: initialValue,
          keyboardType: inputType,
          decoration: InputDecoration(
            filled: true,
            fillColor: context.colors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
          style: TextStyles.bold14.copyWith(color: context.colors.onSurface),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
