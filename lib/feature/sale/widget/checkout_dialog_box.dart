import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_state.dart';
import 'package:my_web_app/feature/sale/widget/dialog_card.dart';

import 'package:shadcn_ui/shadcn_ui.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  void _showDialogBox(BuildContext rootContext) {
    showDialog(
      context: rootContext,
      builder: (context) {
        return ShadDialog(
          //   backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Report",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // 🛒 List of items in cart
                  SizedBox(
                    height: 300,
                    child: BlocBuilder<SaleBloc, SaleState>(
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            final product = state.cartItems[index];
                            return DemoCard(product: product);
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ✅ Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ShadButton(
                        onPressed: () => Navigator.of(context).pop(),
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black,
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 10),
                      ShadButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        child: const Text("Confirm"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double scale;
    double fontSize;
    EdgeInsets padding;

    if (width < 748) {
      // 📱 Mobile
      scale = 0.8;
      fontSize = 12;
      padding = const EdgeInsets.symmetric(horizontal: 4, vertical: 10);
    } else if (width < 775) {
      // 💻 Tablet
      scale = 0.7;
      fontSize = 8;
      padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 12);
    } else if (width < 1200) {
      // 💻 Tablet
      scale = 1;
      fontSize = 8;
      padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 12);
    } else {
      // 🖥️ Desktop
      scale = 1;
      fontSize = 14;
      padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 0);
    }

    return Transform.scale(
      scale: scale,
      child: ShadButton(
        onPressed: () => _showDialogBox(context),
        padding: padding,
        backgroundColor: Colors.black,
        hoverBackgroundColor: ShadTheme.of(context).colorScheme.muted,
        child: Text(
          'Complete order',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: ShadTheme.of(context).colorScheme.secondaryForeground,
          ),
        ),
      ),
    );
  }
}
