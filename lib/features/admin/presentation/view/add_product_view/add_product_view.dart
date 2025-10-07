import 'dart:io';

import 'package:coffee_app/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../core/widgets/prettier_tap.dart';

// Color Palette
class ColorPalette {
  static const Color orangeCrayola = Color(0xFFFF6B35);
  static const Color antiFlashWhite = Color(0xFFF0F0F0);
  static const Color raisinBlack = Color(0xFF2A2A2A);
  static const Color cadetGray = Color(0xFFA0A0A0);
  static const Color eerieBlack = Color(0xFF0F0F0F);
  static const Color platinum = Color(0xFFE5E5E5);
  static const Color linen = Color(0xFFFAF6F1);
  static const Color charcoalGray = Color(0xFF4A4A4A);
}

// Main App
void main() {
  runApp(const AdminDashboardApp());
}

class AdminDashboardApp extends StatelessWidget {
  const AdminDashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: ColorPalette.orangeCrayola,
          onPrimary: ColorPalette.antiFlashWhite,
          secondary: ColorPalette.raisinBlack,
          onSecondary: ColorPalette.cadetGray,
          error: ColorPalette.orangeCrayola,
          onError: ColorPalette.antiFlashWhite,
          surface: ColorPalette.eerieBlack,
          onSurface: ColorPalette.antiFlashWhite,
        ),
        scaffoldBackgroundColor: ColorPalette.eerieBlack,
        useMaterial3: true,
      ),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const AnalysisScreen(),
    const StockScreen(),
    const AddProductViewBody(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: context.colors.secondary, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: ColorPalette.raisinBlack,
          selectedItemColor: context.colors.primary,
          unselectedItemColor: context.colors.onSecondary,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Analysis',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              label: 'Stock',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Add',
            ),
          ],
        ),
      ),
    );
  }
}

// Analysis Screen
class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.colors.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage your store',
              style: TextStyle(fontSize: 14, color: context.colors.onSecondary),
            ),
            const SizedBox(height: 24),

            // Top Categories
            _buildCategoryCard(context),
            const SizedBox(height: 20),

            // Demographics
            _buildDemographicsCard(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorPalette.raisinBlack,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorPalette.cadetGray.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.colors.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 200,
                  child: CustomPaint(
                    painter: PieChartPainter([
                      ChartSection(35, ColorPalette.orangeCrayola),
                      ChartSection(25, const Color(0xFF4ECDC4)),
                      ChartSection(20, const Color(0xFFFFD93D)),
                      ChartSection(12, const Color(0xFF6C5CE7)),
                      ChartSection(8, const Color(0xFFE17899)),
                    ]),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(
                      context,
                      'Electronics',
                      '35%',
                      ColorPalette.orangeCrayola,
                    ),
                    const SizedBox(height: 12),
                    _buildLegendItem(
                      context,
                      'Fashion',
                      '25%',
                      const Color(0xFF4ECDC4),
                    ),
                    const SizedBox(height: 12),
                    _buildLegendItem(
                      context,
                      'Home',
                      '20%',
                      const Color(0xFFFFD93D),
                    ),
                    const SizedBox(height: 12),
                    _buildLegendItem(
                      context,
                      'Sports',
                      '12%',
                      const Color(0xFF6C5CE7),
                    ),
                    const SizedBox(height: 12),
                    _buildLegendItem(
                      context,
                      'Others',
                      '8%',
                      const Color(0xFFE17899),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    String label,
    String percentage,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: context.colors.onSurface),
            ),
          ],
        ),
        Text(
          percentage,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: context.colors.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildDemographicsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorPalette.raisinBlack,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorPalette.cadetGray.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Demographics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.colors.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: CustomPaint(
              painter: BarChartPainter([
                BarData(2400),
                BarData(4200),
                BarData(3800),
                BarData(2100),
                BarData(1500),
              ], ColorPalette.orangeCrayola),
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '18-24',
                          style: TextStyle(
                            color: context.colors.onSecondary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '25-34',
                          style: TextStyle(
                            color: context.colors.onSecondary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '35-44',
                          style: TextStyle(
                            color: context.colors.onSecondary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '45-54',
                          style: TextStyle(
                            color: context.colors.onSecondary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '55+',
                          style: TextStyle(
                            color: context.colors.onSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BarChartGroupData _buildBarGroup(int x, double y, BuildContext context) {
  //   return BarChartGroupData(
  //     x: x,
  //     barRods: [
  //       BarChartRodData(
  //         toY: y,
  //         color: context.colors.primary,
  //         width: 40,
  //         borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
  //       ),
  //     ],
  //   );
  // }

  BarChartGroupData _buildBarGroup(int x, double y, BuildContext context) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: context.colors.primary,
          width: 40,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
      ],
    );
  }
}

// Stock Screen
class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Product> _products = [
    Product(
      name: 'Wireless Headphones',
      sku: 'WH-1001',
      category: 'Electronics',
      stock: 145,
      price: 89.99,
      status: ProductStatus.inStock,
    ),
    Product(
      name: 'Smart Watch Pro',
      sku: 'SW-2045',
      category: 'Electronics',
      stock: 23,
      price: 299.99,
      status: ProductStatus.low,
    ),
    Product(
      name: 'Running Shoes',
      sku: 'RS-3312',
      category: 'Sports',
      stock: 0,
      price: 129.99,
      status: ProductStatus.out,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Dashboard',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Manage your store',
                  style: TextStyle(
                    fontSize: 14,
                    color: context.colors.onSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _searchController,
                  style: TextStyle(color: context.colors.onSurface),
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: TextStyle(color: context.colors.onSecondary),
                    prefixIcon: Icon(
                      Icons.search,
                      color: context.colors.onSecondary,
                    ),
                    filled: true,
                    fillColor: ColorPalette.raisinBlack,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(context, _products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorPalette.raisinBlack,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorPalette.cadetGray.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: context.colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SKU: ${product.sku}',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colors.onSecondary,
                      ),
                    ),
                    Text(
                      product.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.colors.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(context, product.status),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: ColorPalette.cadetGray.withOpacity(0.2)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stock',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colors.onSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${product.stock}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.colors.onSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Edit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  foregroundColor: context.colors.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, ProductStatus status) {
    Color color;
    String text;

    switch (status) {
      case ProductStatus.inStock:
        color = Colors.green;
        text = 'In Stock';
        break;
      case ProductStatus.low:
        color = Colors.orange;
        text = 'Low';
        break;
      case ProductStatus.out:
        color = context.colors.primary;
        text = 'Out';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

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
                      value: _selectedCategory,
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
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Ionicons.list_outline),
                        hintText: "Select Category",

                        contentPadding: const EdgeInsets.symmetric(
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

// Product Model
class Product {
  final String name;
  final String sku;
  final String category;
  final int stock;
  final double price;
  final ProductStatus status;

  Product({
    required this.name,
    required this.sku,
    required this.category,
    required this.stock,
    required this.price,
    required this.status,
  });
}

enum ProductStatus { inStock, low, out }

// Custom Chart Painters
class ChartSection {
  final double value;
  final Color color;

  ChartSection(this.value, this.color);
}

class PieChartPainter extends CustomPainter {
  final List<ChartSection> sections;

  PieChartPainter(this.sections);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.5;
    final innerRadius = radius * 0.6;

    double total = sections.fold(0, (sum, section) => sum + section.value);
    double startAngle = -90 * 3.14159 / 180;

    for (var section in sections) {
      final sweepAngle = (section.value / total) * 2 * 3.14159;

      final paint = Paint()
        ..color = section.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius - innerRadius;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: (radius + innerRadius) / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BarData {
  final double value;

  BarData(this.value);
}

class BarChartPainter extends CustomPainter {
  final List<BarData> data;
  final Color barColor;

  BarChartPainter(this.data, this.barColor);

  @override
  void paint(Canvas canvas, Size size) {
    final maxValue = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);
    final barWidth = (size.width - 80) / data.length * 0.6;
    final spacing = (size.width - 80) / data.length;

    for (int i = 0; i < data.length; i++) {
      final barHeight = (data[i].value / maxValue) * (size.height - 40);
      final left = 40 + i * spacing + (spacing - barWidth) / 2;
      final top = size.height - 40 - barHeight;

      final paint = Paint()
        ..color = barColor
        ..style = PaintingStyle.fill;

      final rect = RRect.fromRectAndCorners(
        Rect.fromLTWH(left, top, barWidth, barHeight),
        topLeft: const Radius.circular(6),
        topRight: const Radius.circular(6),
      );

      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
