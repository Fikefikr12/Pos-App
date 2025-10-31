import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_event.dart';
import 'package:my_web_app/feature/sale/bloc/sale_state.dart';
import 'package:my_web_app/model/productModel.dart';
import 'package:my_web_app/feature/sale/widget/catagory_chips.dart';
import 'package:my_web_app/feature/sale/widget/item_card.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ItemSelector extends StatefulWidget {
  const ItemSelector({super.key});

  @override
  State<ItemSelector> createState() => _ItemSelectorState();
}

class _ItemSelectorState extends State<ItemSelector> {
  final TextEditingController searchController = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, dynamic>> productJson = [
    {
      "name": "French Vanilla Fantasy",
      "price": "\$12.83",
      "image": "assets/1.jpeg",
      "category": "Food",
      "cartqt": 0,
    },
    {
      "name": "Almond Amore Fantasy",
      "price": "\$9.54",
      "image": "assets/2.jpeg",
      "category": "Soft Drink",
      "cartqt": 0,
    },
    {
      "name": "Cinnamon Swirl",
      "price": "\$8.49",
      "image": "assets/3.jpeg",
      "category": "Coffee",
      "cartqt": 0,
    },
    {
      "name": "Raspberry Ripple",
      "price": "\$8.12",
      "image": "assets/4.jpeg",
      "category": "Food",
      "cartqt": 0,
    },
    {
      "name": "Tiramisu Temptation",
      "price": "\$6.19",
      "image": "assets/5.jpeg",
      "category": "Soft Drink",
      "cartqt": 0,
    },
    {
      "name": "White Chocolate",
      "price": "\$6.54",
      "image": "assets/6.jpeg",
      "category": "Coffee",
      "cartqt": 0,
    },
    {
      "name": "Dark Roast Dynamic",
      "price": "\$12.03",
      "image": "assets/7.jpeg",
      "category": "Food",
      "cartqt": 0,
    },
    {
      "name": "Irish Cream Infusion",
      "price": "\$11.63",
      "image": "assets/8.jpg",
      "category": "Alcohol",
      "cartqt": 0,
    },
    {
      "name": "Habesha Beer",
      "price": "\$100.0",
      "image": "assets/7.jpeg",
      "category": "Alcohol",
      "cartqt": 0,
    },
    {
      "name": "Arekie Teji",
      "price": "\$50.6",
      "image": "assets/8.jpg",
      "category": "Alcohol",
      "cartqt": 0,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize products in BLoC after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final allProducts = productJson
          .map((data) => Product.fromJson(data))
          .toList();
      context.read<SaleBloc>().add(
        InitializeProductsEvent(products: allProducts),
      );
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        searchController.clear();
        context.read<SaleBloc>().add(SearchItemEvent(''));
      }
    });
  }

  void _filterProducts(String category, BuildContext context) {
    if (category == "All") {
      context.read<SaleBloc>().add(SearchItemEvent(''));
    } else {
      // Filter by category using the search functionality
      context.read<SaleBloc>().add(SearchItemEvent(category));
    }
  }

  double _calculateMinItemWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 390) return 120;
    if (screenWidth < 601) return 130;
    if (screenWidth < 1150) return 150;
    return 180;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;
    return BlocBuilder<SaleBloc, SaleState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: theme.background,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.book),
                  const SizedBox(width: 8),
                  const Text(
                    "Menu",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  // Replace IconButton with search TextField or toggle button
                  // if (!_isSearching)
                  //   IconButton(
                  //     icon: const Icon(Icons.search),
                  //     iconSize: 25,
                  //     onPressed: _toggleSearch,
                  //   )
                  // else
                  Container(
                    width: 200,
                    //height: 50,
                    child: ShadInput(
                      controller: searchController,
                      autofocus: true,
                      placeholder: Text(
                        "search...",
                        style: TextStyle(color: theme.popoverForeground),
                      ),
                      leading: Icon(Icons.search),
                      trailing: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.close),
                              onPressed: _toggleSearch,
                            )
                          : null,
                      onChanged: (value) {
                        context.read<SaleBloc>().add(SearchItemEvent(value));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CatagoryChips(
                onCategorySelected: (category) =>
                    _filterProducts(category, context),
                products: productJson,
              ),
              const SizedBox(height: 8),
              // Search results indicator
              // if (state.searchQuery.isNotEmpty)
              //   Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 8),
              //     child: Row(
              //       children: [
              //         Text(
              //           "Search results for: \"${state.searchQuery}\"",
              //           style: TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w500,
              //             color: Colors.grey[600],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              Expanded(
                child: ResponsiveGridList(
                  minItemWidth: _calculateMinItemWidth(context),
                  horizontalGridSpacing: 5,
                  verticalGridSpacing: 10,
                  rowMainAxisAlignment: MainAxisAlignment.start,
                  // Use filteredItems from BLoC state
                  children: state.filteredItems
                      .map((product) => ItemCard(product: product))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
