import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_event.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:my_web_app/feature/sale/bloc/sale_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_state.dart';
import 'package:my_web_app/feature/sale/widget/order_buttons.dart';
import 'package:my_web_app/feature/sale/widget/cart_card.dart';
import 'package:my_web_app/feature/sale/widget/checkout_dialog_box.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:my_web_app/feature/sale/page/sale_view.dart'; // 👈 Import your SaleView

class CartView extends StatefulWidget {
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  const CartView({super.key, this.showBackButton = false, this.onBackPressed});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    // 👇 If user resizes from mobile to desktop, navigate to SaleView
    if (!breakpoints.isMobile && widget.showBackButton) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const SaleView()),
            (route) => false,
          );
        }
      });
    }

    return Container(
      decoration: BoxDecoration(
        color: ShadTheme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ShadTheme.of(context).colorScheme.border),
      ),

      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Container(child: _buildOrderButtons()),
              ),
              //   const SizedBox(height: 1),

              // 🔹 Cart Items Grid
              Expanded(
                child: BlocBuilder<SaleBloc, SaleState>(
                  builder: (context, state) {
                    if (state.cartItems.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Your cart is empty.",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ResponsiveGridList(
                        minItemWidth: 220,
                        horizontalGridSpacing: 12,
                        verticalGridSpacing: 12,
                        minItemsPerRow: 1,
                        maxItemsPerRow: 1,
                        children: List.generate(state.cartItems.length, (
                          index,
                        ) {
                          final product = state.cartItems[index];
                          return CartCard(product: product);
                        }),
                      ),
                    );
                  },
                ),
              ),

              // 🔹 Summary & Action Buttons
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                ResponsiveBreakpoints.of(context).isDesktop
                                ? 20
                                : ResponsiveBreakpoints.of(context).isTablet
                                ? 8
                                : ResponsiveBreakpoints.of(context).isMobile
                                ? 10
                                : 10,
                          ),
                          child: Text(
                            "Total items:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        BlocBuilder<SaleBloc, SaleState>(
                          builder: (context, state) {
                            final totalItems = state.cartItems.fold<int>(
                              0,
                              (sum, item) => sum + item.cartQt,
                            );
                            return Text("$totalItems");
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                ResponsiveBreakpoints.of(context).isDesktop
                                ? 20
                                : ResponsiveBreakpoints.of(context).isTablet
                                ? 2
                                : ResponsiveBreakpoints.of(context).isMobile
                                ? 10
                                : 10,
                          ),
                          child: Text(
                            "Total amount:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  ResponsiveBreakpoints.of(context).isDesktop
                                  ? 16
                                  : ResponsiveBreakpoints.of(context).isTablet
                                  ? 12
                                  : ResponsiveBreakpoints.of(context).isMobile
                                  ? 14
                                  : 16,
                            ),
                          ),
                        ),
                        BlocBuilder<SaleBloc, SaleState>(
                          builder: (context, state) {
                            final totalAmount = state.cartItems.fold<double>(
                              0,
                              (sum, item) => sum + (item.price * item.cartQt),
                            );
                            return Text(
                              "\$${totalAmount.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize:
                                    ResponsiveBreakpoints.of(context).isDesktop
                                    ? 14
                                    : ResponsiveBreakpoints.of(context).isTablet
                                    ? 10
                                    : ResponsiveBreakpoints.of(context).isMobile
                                    ? 10
                                    : 10,
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        const DialogBox(),
                      ],
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

  Widget _buildOrderButtons() {
    return ResponsiveGridList(
      minItemWidth: 150,
      listViewBuilderOptions: ListViewBuilderOptions(shrinkWrap: true),
      children: const [
        ReusableButton(label: "Order Details", icon: Icons.receipt_long),
        ReusableButton(label: "Reset Order", icon: Icons.delete),

        ReusableButton(
          label: "Dine In",
          icon: Icons.restaurant,
          trailing: Icon(Icons.arrow_drop_down),
        ),
      ],
    );
  }
}
