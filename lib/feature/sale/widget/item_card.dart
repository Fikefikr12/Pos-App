import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_event.dart';
import 'package:my_web_app/model/productModel.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ItemCard extends StatelessWidget {
  final Product product;

  const ItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = ShadTheme.of(context).colorScheme;

    // 🎚 Default values (desktop size)
    double imageHeight = 150;
    double fontSize = 14;
    double priceFontSize = 14;
    double iconSize = 24;
    double padding = 16;

    // 📱 Extra small layout (mobile < 390px)
    if (width < 390) {
      imageHeight = 100;
      fontSize = 11;
      priceFontSize = 11;
      iconSize = 18;
      padding = 8;
    }
    // 💻 Medium-small layout (601px – 1150px)
    else if (width >= 601 && width <= 1150) {
      imageHeight = 120;
      fontSize = 12;
      priceFontSize = 12;
      iconSize = 20;
      padding = 10;
    }

    return ShadCard(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼️ Product image container
          Container(
            height: imageHeight,
            width: double.infinity,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //  color: Colors.grey.shade300,
              color: theme.input,
            ),
            child: Image.asset(product.image, fit: BoxFit.contain),
          ),

          const SizedBox(height: 8),

          // 🏷️ Product name
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              product.name,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 💰 Price + Add button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: priceFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  iconSize: iconSize,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final countBloc = context.read<SaleBloc>();
                    final currentCart = countBloc.state.cartItems;

                    final existingItem = currentCart.any(
                      (p) => p.name == product.name,
                    );

                    if (existingItem) {
                      countBloc.add(IncrementItemQuantityEvent(item: product));
                    } else {
                      countBloc.add(AddItemToCartEvent(item: product));
                    }
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
