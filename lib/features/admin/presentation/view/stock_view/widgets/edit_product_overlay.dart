import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/core/widgets/overlay_container.dart';

import '../../../../../../core/helper/ui_helpers.dart';
import '../../../../../../core/model/product_variants_model.dart';

void editProductOverlay(
  BuildContext context, {
  required List<ProductVariantsModel> variants,
  required VoidCallback onSave,
}) {
  UiHelpers.showOverlay(
    context: context,
    child: EditProductOverlay(variants: variants, onSave: onSave),
  );
}

class EditProductOverlay extends StatefulWidget {
  final List<ProductVariantsModel> variants;
  final VoidCallback onSave;

  const EditProductOverlay({
    super.key,
    required this.variants,
    required this.onSave,
  });

  @override
  State<EditProductOverlay> createState() => _EditProductOverlayState();
}

class _EditProductOverlayState extends State<EditProductOverlay> {
  late List<ProductVariantsModel> _variants;

  @override
  void initState() {
    super.initState();
    _variants = widget.variants.map((v) => v).toList();
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

  @override
  Widget build(BuildContext context) {
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
              //======================== Header ========================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48), // alignment buffer
                  Text('Edit Variations', style: TextStyles.bold20),
                  PrettierTap(
                    shrink: 1,
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Ionicons.close,
                      color: context.colors.onSecondary,
                    ),
                  ),
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 12,
                    children: List.generate(_variants.length, (index) {
                      final variant = _variants[index];
                      return _buildVariantCard(context, variant, index);
                    }),
                  ),
                ),
              ),

              //======================== Add Variant ========================
              if (_variants.length < 3)
                PrettierTap(
                  onPressed: _addVariant,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.colors.outline.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Ionicons.add_circle_outline,
                            color: context.colors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Add Variant",
                            style: TextStyles.bold14.copyWith(
                              color: context.colors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              //======================== Save ========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: CustomElevatedButton(
                  height: 52,
                  contentPadding: const EdgeInsets.all(8),
                  onPressed: () {
                    widget.onSave();
                    Navigator.pop(context);
                  },
                  child: Text("Save Changes", style: TextStyles.bold16),
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
  ) {
    final isLow = variant.quantity < 20 && variant.quantity > 0;
    final isOut = variant.quantity == 0;
    Color color = isOut
        ? context.colors.primary
        : (isLow ? Colors.orange : Colors.green);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Variant ${index + 1}",
                style: TextStyles.bold16.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
              if (_variants.length > 1)
                PrettierTap(
                  shrink: 1,
                  onPressed: () => _removeVariant(index),
                  child: Icon(
                    Ionicons.trash_outline,
                    size: 20,
                    color: context.colors.onSecondary,
                  ),
                ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: "Size",
                  initialValue: variant.size,
                  onChanged: (v) => _variants[index] = _variants[index],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTextField(
                  label: "Price",
                  initialValue: variant.price.toString(),
                  inputType: TextInputType.number,
                  onChanged: (v) => _variants[index] = _variants[index],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTextField(
                  label: "Stock",
                  initialValue: variant.quantity.toString(),
                  inputType: TextInputType.number,
                  onChanged: (v) => _variants[index] = _variants[index],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              isOut ? "Out of Stock" : (isLow ? "Low Stock" : "In Stock"),
              style: TextStyles.regular12.copyWith(color: color),
            ),
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
    return TextFormField(
      initialValue: initialValue,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyles.regular12.copyWith(
          color: context.colors.onSecondary,
        ),
        isDense: true,
      ),
      onChanged: onChanged,
    );
  }
}
