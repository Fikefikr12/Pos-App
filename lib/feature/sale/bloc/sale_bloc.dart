import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_event.dart';
import 'package:my_web_app/feature/sale/bloc/sale_state.dart';
import 'package:my_web_app/model/productModel.dart';

class SaleBloc extends HydratedBloc<SaleEvent, SaleState> {
  SaleBloc() : super(SaleState()) {
    on<AddItemToCartEvent>(_addItemToCart);
    on<RemoveItemFromCartEvent>(_removeItemCartEvent);
    on<IncrementItemQuantityEvent>(_incrementItemQuantityEvent);
    on<DecrementItemQuantityEvent>(_decrementQuantity);
    on<ThemeChangeEvent>(_themeChangeEvent);
    on<SearchItemEvent>(_searchItemEvent);
    on<InitializeProductsEvent>(_initializeProducts); // Add this event
    on<SelectSearchedItemEvent>(_selectSearchedItem);
    on<ToggleCartViewEvent>(_toggleCartViewEvent);
  }

  _addItemToCart(AddItemToCartEvent event, Emitter<SaleState> emit) {
    try {
      final updatedCart = List<Product>.from(state.cartItems)..add(event.item);
      emit(state.copyWith(cartItems: updatedCart));
      print("itemmmm : ${state.cartItems!.length}");
    } catch (e) {
      //emit(state.copyWith(cartItems: []));
      print("error: $e");
    }
  }

  void _removeItemCartEvent(
    RemoveItemFromCartEvent event,
    Emitter<SaleState> emit,
  ) {
    try {
      final updatedCart = List<Product>.from(state.cartItems)
        ..remove(event.item);
      emit(state.copyWith(cartItems: updatedCart));
      print(
        "yeee , i remove one item${event.item.name} | Total: ${updatedCart.length} ",
      );
    } catch (err) {
      print("error $err");
    }
  }

  void _incrementItemQuantityEvent(
    IncrementItemQuantityEvent event,
    Emitter<SaleState> emit,
  ) {
    final updatedCart = List<Product>.from(state.cartItems);
    final index = updatedCart.indexWhere((p) => p.name == event.item.name);

    if (index >= 0) {
      updatedCart[index] = updatedCart[index].copyWith(
        cartQt: updatedCart[index].cartQt + 1,
      );
      emit(state.copyWith(cartItems: updatedCart));
    }
  }

  void _decrementQuantity(
    DecrementItemQuantityEvent event,
    Emitter<SaleState> emit,
  ) {
    final updatedCart = List<Product>.from(state.cartItems);
    final index = updatedCart.indexWhere((p) => p.name == event.item.name);

    if (index >= 0 && updatedCart[index].cartQt > 1) {
      updatedCart[index] = updatedCart[index].copyWith(
        cartQt: updatedCart[index].cartQt - 1,
      );
      emit(state.copyWith(cartItems: updatedCart));
    } else if (index >= 0 && updatedCart[index].cartQt == 1) {
      // remove item when quantity = 1 and minus pressed
      updatedCart.removeAt(index);
      emit(state.copyWith(cartItems: updatedCart));
    }
  }

  /////////// to toggle event
  FutureOr<void> _themeChangeEvent(
    ThemeChangeEvent event,
    Emitter<SaleState> emit,
  ) {
    emit(state.copyWith(isDark: event.isDark));
  }

  ////////////////// related to search system
  // Add this method to initialize products
  FutureOr<void> _initializeProducts(
    InitializeProductsEvent event,
    Emitter<SaleState> emit,
  ) {
    emit(
      state.copyWith(
        allProducts: event.products,
        filteredItems: event.products,
      ),
    );
  }

  // Updated search method
  FutureOr<void> _searchItemEvent(
    SearchItemEvent event,
    Emitter<SaleState> emit,
  ) {
    final query = event.query.toLowerCase().trim();
    // query  --- The search term entered by user
    if (query.isEmpty) {
      // If search is empty, show all products
      emit(
        state.copyWith(
          filteredItems: List.from(state.allProducts),
          searchQuery: '',
        ),
      );
    } else {
      // Search in all products, not just cart items
      final filtered = state.allProducts
          .where(
            (product) =>
                product.name.toLowerCase().contains(query) ||
                product.category.toLowerCase().contains(query) ||
                product.price.toString().toLowerCase().contains(query),
          )
          .toList();

      emit(state.copyWith(filteredItems: filtered, searchQuery: event.query));
    }
  }

  FutureOr<void> _selectSearchedItem(
    SelectSearchedItemEvent event,
    Emitter<SaleState> emit,
  ) {
    emit(
      state.copyWith(
        filteredItems: [event.selectedItem],
        searchQuery: event.selectedItem.name,
      ),
    );
  }

  @override
  SaleState? fromJson(Map<String, dynamic> json) {
    try {
      // 1

      return SaleState(
        // 2
        isDark: json['isDark'] as bool? ?? false,
        // If you want to persist cart items too, deserialize here
      );
    } catch (e) {
      return SaleState();
    }
  }

  @override
  Map<String, dynamic>? toJson(SaleState state) {
    return {
      // 3
      'isDark': state.isDark,
    };
  }

  FutureOr<void> _toggleCartViewEvent(
    ToggleCartViewEvent event,
    Emitter<SaleState> emit,
  ) {
    emit(state.copyWith(showCartView: !state.showCartView));
  }
}
