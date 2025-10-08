import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/model/categories_model.dart';
import '../../../../../core/model/product_model.dart';
import '../../../../../core/model/product_variants_model.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/presentation/manager/home_filter_cubit/home_filter_cubit.dart';
import '../../../../home/presentation/view/home_view/widgets/filter_overlay.dart';
import '../add_product_view/add_product_view.dart';
import 'widgets/edit_product_overlay.dart';

// Main App
void main() {
  runApp(const AdminDashboardApp());
}

class AdminDashboardApp extends StatelessWidget {
  const AdminDashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Admin Dashboard',
      debugShowCheckedModeBanner: false,

      home: AdminDashboard(),
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
          backgroundColor: context.colors.onSurface,
          selectedItemColor: context.colors.primary,
          unselectedItemColor: context.colors.onSecondary,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.bar_chart),
            //   label: 'Analysis',
            // ),
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

// // Analysis Screen
// class AnalysisScreen extends StatelessWidget {
//   const AnalysisScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Admin Dashboard',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: context.colors.onSurface,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               'Manage your store',
//               style: TextStyle(fontSize: 14, color: context.colors.onSecondary),
//             ),
//             const SizedBox(height: 24),

//             // Top Categories
//             _buildCategoryCard(context),
//             const SizedBox(height: 20),

//             // Demographics
//             _buildDemographicsCard(context),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryCard(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: context.colors.onSurface,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: ColorPalette.cadetGray.withValues(alpha:  0.2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Top Categories',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: context.colors.onSurface,
//             ),
//           ),
//           const SizedBox(height: 24),
//           Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: SizedBox(
//                   height: 200,
//                   child: CustomPaint(
//                     painter: PieChartPainter([
//                       ChartSection(35, ColorPalette.orangeCrayola),
//                       ChartSection(25, const Color(0xFF4ECDC4)),
//                       ChartSection(20, const Color(0xFFFFD93D)),
//                       ChartSection(12, const Color(0xFF6C5CE7)),
//                       ChartSection(8, const Color(0xFFE17899)),
//                     ]),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 24),
//               Expanded(
//                 flex: 3,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildLegendItem(
//                       context,
//                       'Electronics',
//                       '35%',
//                       ColorPalette.orangeCrayola,
//                     ),
//                     const SizedBox(height: 12),
//                     _buildLegendItem(
//                       context,
//                       'Fashion',
//                       '25%',
//                       const Color(0xFF4ECDC4),
//                     ),
//                     const SizedBox(height: 12),
//                     _buildLegendItem(
//                       context,
//                       'Home',
//                       '20%',
//                       const Color(0xFFFFD93D),
//                     ),
//                     const SizedBox(height: 12),
//                     _buildLegendItem(
//                       context,
//                       'Sports',
//                       '12%',
//                       const Color(0xFF6C5CE7),
//                     ),
//                     const SizedBox(height: 12),
//                     _buildLegendItem(
//                       context,
//                       'Others',
//                       '8%',
//                       const Color(0xFFE17899),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLegendItem(
//     BuildContext context,
//     String label,
//     String percentage,
//     Color color,
//   ) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Container(
//               width: 12,
//               height: 12,
//               decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//             ),
//             const SizedBox(width: 8),
//             Text(
//               label,
//               style: TextStyle(fontSize: 14, color: context.colors.onSurface),
//             ),
//           ],
//         ),
//         Text(
//           percentage,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: context.colors.onSurface,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDemographicsCard(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: context.colors.onSurface,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: ColorPalette.cadetGray.withValues(alpha:  0.2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Demographics',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: context.colors.onSurface,
//             ),
//           ),
//           const SizedBox(height: 24),
//           SizedBox(
//             height: 200,
//             child: CustomPaint(
//               painter: BarChartPainter([
//                 BarData(2400),
//                 BarData(4200),
//                 BarData(3800),
//                 BarData(2100),
//                 BarData(1500),
//               ], ColorPalette.orangeCrayola),
//               child: Column(
//                 children: [
//                   Expanded(child: Container()),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0, left: 40),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text(
//                           '18-24',
//                           style: TextStyle(
//                             color: context.colors.onSecondary,
//                             fontSize: 12,
//                           ),
//                         ),
//                         Text(
//                           '25-34',
//                           style: TextStyle(
//                             color: context.colors.onSecondary,
//                             fontSize: 12,
//                           ),
//                         ),
//                         Text(
//                           '35-44',
//                           style: TextStyle(
//                             color: context.colors.onSecondary,
//                             fontSize: 12,
//                           ),
//                         ),
//                         Text(
//                           '45-54',
//                           style: TextStyle(
//                             color: context.colors.onSecondary,
//                             fontSize: 12,
//                           ),
//                         ),
//                         Text(
//                           '55+',
//                           style: TextStyle(
//                             color: context.colors.onSecondary,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // BarChartGroupData _buildBarGroup(int x, double y, BuildContext context) {
//   //   return BarChartGroupData(
//   //     x: x,
//   //     barRods: [
//   //       BarChartRodData(
//   //         toY: y,
//   //         color: context.colors.primary,
//   //         width: 40,
//   //         borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
//   //       ),
//   //     ],
//   //   );
//   // }

//   // BarChartGroupData _buildBarGroup(int x, double y, BuildContext context) {
//   //   return BarChartGroupData(
//   //     x: x,
//   //     barRods: [
//   //       BarChartRodData(
//   //         toY: y,
//   //         color: context.colors.primary,
//   //         width: 40,
//   //         borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
//   //       ),
//   //     ],
//   //   );
//   // }
// }

// Stock Screen

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final List<ProductModel> _products = [
    ProductModel(
      id: 1,
      name: 'Espresso Classic',
      description: 'Rich, full-bodied espresso beans',
      discount: 10,
      rating: 4.5,
      categoryId: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800',
      createdAt: DateTime.now(),
      category: CategoriesModel(id: 1, name: 'Coffee'),
      productVariants: [
        ProductVariantsModel(
          id: 1,
          size: '250g',
          price: 12.99,
          quantity: 120,
          productId: 1,
        ),
        ProductVariantsModel(
          id: 2,
          size: '500g',
          price: 19.99,
          quantity: 60,
          productId: 1,
        ),
      ],
    ),
    ProductModel(
      id: 2,
      name: 'Latte Deluxe',
      description: 'Smooth and creamy latte blend',
      discount: 5,
      rating: 4.2,
      categoryId: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800',
      createdAt: DateTime.now(),
      category: CategoriesModel(id: 1, name: 'Coffee'),
      productVariants: [
        ProductVariantsModel(
          id: 3,
          size: '250ml',
          price: 8.99,
          quantity: 18,
          productId: 2,
        ),
      ],
    ),
    ProductModel(
      id: 3,
      name: 'Mocha Delight',
      description: 'Chocolate-flavored coffee blend',
      discount: 0,
      rating: 4.7,
      categoryId: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800',
      createdAt: DateTime.now(),
      category: CategoriesModel(id: 1, name: 'Coffee'),
      productVariants: [
        ProductVariantsModel(
          id: 4,
          size: '500ml',
          price: 10.99,
          quantity: 0,
          productId: 3,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16,

        children: [
          CustomAppBar(
            leading: CustomIconButton(
              padding: 8,
              onPressed: () {},
              child: Icon(
                Ionicons.chevron_back,
                color: context.colors.onSecondary,
              ),
            ),
          ),
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _buildProductCard(context, product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Admin Dashboard',
          style: TextStyles.bold20.copyWith(color: context.colors.onSurface),
        ),
        const SizedBox(height: 4),
        Text(
          'Manage your products and stock levels',
          style: TextStyles.regular15.copyWith(
            color: context.colors.onSecondary,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  onSubmitted: (value) {},
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: CustomIconButton(
                      onPressed: () {},
                      child: const Icon(Ionicons.search_outline),
                    ),
                    hintText: S.current.search,
                    prefixIconColor: context.colors.onSecondary,
                    hintStyle: TextStyles.medium16.copyWith(
                      color: context.colors.onSecondary,
                    ),
                  ),
                  onChanged: (value) {
                    context.read<HomeFilterCubit>().selectedQuery = value;
                    context.read<HomeFilterCubit>().setSearch();
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            CustomIconButton(
              onPressed: () {
                filterOverlay(context);
              },
              hight: 48,
              width: 48,
              child: BlocBuilder<HomeFilterCubit, HomeFilterState>(
                builder: (context, state) {
                  return Icon(
                    Ionicons.filter,
                    color: context.read<HomeFilterCubit>().isFiltered()
                        ? context.colors.primary
                        : context.colors.onSecondary,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel product) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ========== PRODUCT HEADER ==========
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CustomRoundedImage(
                      imageUrl: product.imageUrl,
                      aspectRatio: 1,
                      width: 64,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyles.bold16.copyWith(
                              color: context.colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.category?.name ?? 'Unknown',
                            style: TextStyles.regular12.copyWith(
                              color: context.colors.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// SWAPPED: Edit Button on LEFT, Status on RIGHT
              Row(
                children: [
                  CustomElevatedButton(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    onPressed: () {
                      editProductOverlay(context, variants: [], onSave: () {});
                    },
                    height: 34,
                    width: 86,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Edit", style: TextStyles.bold14),
                        Icon(
                          Ionicons.create_outline,
                          color: context.colors.onPrimary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(color: context.colors.onSecondary.withValues(alpha: 0.2)),
          const SizedBox(height: 12),

          /// ========== VARIANT LIST ==========
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Variants",
                style: TextStyles.bold14.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 8),

              // Display all product variants
              ...product.productVariants.map((variant) {
                final ProductStatus variantStatus = variant.quantity == 0
                    ? ProductStatus.out
                    : (variant.quantity < 20
                          ? ProductStatus.low
                          : ProductStatus.inStock);

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.colors.outline.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Left side: size + stock
                      Row(
                        children: [
                          _buildInfoColumn(context, 'Size', variant.size),
                          const SizedBox(width: 32),
                          _buildInfoColumn(
                            context,
                            'Stock',
                            '${variant.quantity}',
                          ),
                          const SizedBox(width: 32),
                          _buildInfoColumn(
                            context,
                            'Price',
                            '\$${variant.price.toStringAsFixed(2)}',
                          ),
                        ],
                      ),

                      /// Right side: variant status
                      _buildStatusBadge(context, variantStatus),
                    ],
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.regular12.copyWith(
            color: context.colors.onSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyles.bold16.copyWith(color: context.colors.onSurface),
        ),
      ],
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
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(text, style: TextStyles.bold14.copyWith(color: color)),
    );
  }
}

enum ProductStatus { inStock, low, out }

// class BarData {
//   final double value;

//   BarData(this.value);
// }

// class BarChartPainter extends CustomPainter {
//   final List<BarData> data;
//   final Color barColor;

//   BarChartPainter(this.data, this.barColor);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final maxValue = data.map((d) => d.value).reduce((a, b) => a > b ? a : b);
//     final barWidth = (size.width - 80) / data.length * 0.6;
//     final spacing = (size.width - 80) / data.length;

//     for (int i = 0; i < data.length; i++) {
//       final barHeight = (data[i].value / maxValue) * (size.height - 40);
//       final left = 40 + i * spacing + (spacing - barWidth) / 2;
//       final top = size.height - 40 - barHeight;

//       final paint = Paint()
//         ..color = barColor
//         ..style = PaintingStyle.fill;

//       final rect = RRect.fromRectAndCorners(
//         Rect.fromLTWH(left, top, barWidth, barHeight),
//         topLeft: const Radius.circular(6),
//         topRight: const Radius.circular(6),
//       );

//       canvas.drawRRect(rect, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
