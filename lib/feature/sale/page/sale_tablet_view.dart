import 'package:flutter/material.dart';
import 'package:my_web_app/feature/sale/widget/cart_view.dart';
import 'package:my_web_app/feature/sale/widget/header.dart';
import 'package:my_web_app/feature/sale/widget/item_Selector.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TabletView extends StatelessWidget {
  const TabletView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;

    return Scaffold(
      //rawer: const MyDrawer(),
      backgroundColor: theme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const HeaderView(showBackButton: false),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.card,
                          border: Border.all(color: theme.border),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ItemSelector(),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.card,
                          border: Border.all(color: theme.border),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CartView(),
                      ),
                    ),
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
