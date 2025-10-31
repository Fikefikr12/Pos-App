import 'package:my_web_app/model/productModel.dart';

class SaleState {
  final List<Product> cartItems;
  final List<Product> filteredItems;
  final List<Product> allProducts; // Add this
  final bool isDark;
  final bool showCartView;
  final String searchQuery;

  SaleState({
    List<Product>? cartItems,
    List<Product>? filteredItems,
    List<Product>? allProducts, // Add this
    this.isDark = false,
    this.showCartView = false,
    this.searchQuery = '',
  }) : cartItems = cartItems ?? [],
       filteredItems = filteredItems ?? [],
       allProducts = allProducts ?? [];

  SaleState copyWith({
    List<Product>? cartItems,
    List<Product>? filteredItems,
    List<Product>? allProducts, // Add this
    bool? isDark,
    bool? showCartView,
    String? searchQuery,
  }) {
    return SaleState(
      cartItems: cartItems ?? this.cartItems,
      filteredItems: filteredItems ?? this.filteredItems,
      allProducts: allProducts ?? this.allProducts, // Add this
      isDark: isDark ?? this.isDark,
      showCartView: showCartView ?? this.showCartView,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
