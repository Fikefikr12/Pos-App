import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_event.dart';
import 'package:my_web_app/model/productModel.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CartCard extends StatelessWidget {
  final Product product;

  const CartCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final breakpoints = ResponsiveBreakpoints.of(context);
    final theme = ShadTheme.of(context).colorScheme;

    // 🎚 Responsive scaling
    double imageSize = 100;
    double fontSize = 16;
    double buttonHeight = 30;
    double iconSize = 16;

    return ShadCard(
      radius: BorderRadius.circular(15),
      // width: 500,
      padding: const EdgeInsets.all(3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼️ Product image
          Container(
            width: ResponsiveBreakpoints.of(context).screenWidth > 750
                ? 80
                : ResponsiveBreakpoints.of(context).isTablet
                ? 10
                : ResponsiveBreakpoints.of(context).isMobile
                ? 100
                : 12,
            height: imageSize + 10,
            decoration: BoxDecoration(
              color: theme.input,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Image.asset(product.image, fit: BoxFit.cover)),
          ),
          const SizedBox(width: 10),

          // 📦 Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Delete Button
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: iconSize,
                        ),

                        onPressed: () {
                          context.read<SaleBloc>().add(
                            RemoveItemFromCartEvent(item: product),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                // Options (size/sugar)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Text(
                        "Size : Small",
                        style: TextStyle(
                          fontSize: ResponsiveBreakpoints.of(context).isDesktop
                              ? 14
                              : ResponsiveBreakpoints.of(context).isTablet
                              ? 12
                              : ResponsiveBreakpoints.of(context).isMobile
                              ? 14
                              : 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Sugar : Normal",
                        style: TextStyle(
                          fontSize: ResponsiveBreakpoints.of(context).isDesktop
                              ? 14
                              : ResponsiveBreakpoints.of(context).isTablet
                              ? 12
                              : ResponsiveBreakpoints.of(context).isMobile
                              ? 14
                              : 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 💰 Price + quantity controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        spacing: 2,
                        children: [
                          Text(
                            "\$${product.price}",
                            style: TextStyle(
                              fontSize:
                                  ResponsiveBreakpoints.of(context).isDesktop
                                  ? 14
                                  : ResponsiveBreakpoints.of(context).isTablet
                                  ? 12
                                  : ResponsiveBreakpoints.of(context).isMobile
                                  ? 14
                                  : 12,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(Icons.close, size: iconSize),
                          Text(
                            "${product.cartQt}",
                            style: TextStyle(
                              fontSize:
                                  ResponsiveBreakpoints.of(context).isDesktop
                                  ? 14
                                  : ResponsiveBreakpoints.of(context).isTablet
                                  ? 12
                                  : ResponsiveBreakpoints.of(context).isMobile
                                  ? 14
                                  : 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(right: 2),
                      child: Row(
                        spacing: 2,
                        children: [
                          SizedBox(
                            height: 15,
                            width: 20,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                context.read<SaleBloc>().add(
                                  DecrementItemQuantityEvent(item: product),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            height: 15,
                            width: 20,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.add, size: iconSize),
                              onPressed: () {
                                context.read<SaleBloc>().add(
                                  IncrementItemQuantityEvent(item: product),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
