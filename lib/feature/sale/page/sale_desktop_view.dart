import 'package:flutter/material.dart';
import 'package:my_web_app/feature/sale/widget/cart_view.dart';
import 'package:my_web_app/feature/sale/widget/header.dart';
import 'package:my_web_app/feature/sale/widget/item_Selector.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;

    return Scaffold(
      //  drawer: const MyDrawer(),
      backgroundColor: theme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              // 🔹 HEADER SECTION
              const HeaderView(showDate: true, showBackButton: false),
              const SizedBox(height: 15),

              // 🔹 MAIN CONTENT: Item Selector + Cart
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Item Selector
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.card,
                          border: Border.all(color: theme.border),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const ItemSelector(),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // 🛒 Cart View
                    Expanded(child: const CartView()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
