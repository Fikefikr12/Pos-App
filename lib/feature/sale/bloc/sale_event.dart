import 'package:my_web_app/model/productModel.dart';

abstract class SaleEvent {}

class AddItemToCartEvent extends SaleEvent {
  final Product item;

  AddItemToCartEvent({required this.item});
}

class RemoveItemFromCartEvent extends SaleEvent {
  final Product item;
  RemoveItemFromCartEvent({required this.item});
}

class IncrementItemQuantityEvent extends SaleEvent {
  final Product item;
  IncrementItemQuantityEvent({required this.item});
}

class DecrementItemQuantityEvent extends SaleEvent {
  final Product item;
  DecrementItemQuantityEvent({required this.item});
}

class ThemeChangeEvent extends SaleEvent {
  final bool isDark;
  ThemeChangeEvent(this.isDark);
}

class SearchItemEvent extends SaleEvent {
  final String query;
  SearchItemEvent(this.query);
}

// Add this to your events file
class InitializeProductsEvent extends SaleEvent {
  final List<Product> products;
  InitializeProductsEvent({required this.products});
}

class SelectSearchedItemEvent extends SaleEvent {
  final Product selectedItem;
  SelectSearchedItemEvent(this.selectedItem);
}

class ToggleCartViewEvent extends SaleEvent {} // Add this event
