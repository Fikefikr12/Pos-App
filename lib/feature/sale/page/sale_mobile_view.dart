import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_bloc.dart';
import 'package:my_web_app/feature/sale/bloc/sale_state.dart';
import 'package:my_web_app/feature/sale/widget/cart_view.dart';
import 'package:my_web_app/feature/sale/widget/header.dart';
import 'package:my_web_app/feature/sale/widget/item_Selector.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;
    return Scaffold(
      // drawer: const MyDrawer(),
      backgroundColor: ShadTheme.of(context).colorScheme.background,
      body: BlocBuilder<SaleBloc, SaleState>(
        builder: (context, state) {
          return Column(
            children: [
              HeaderView(
                showCartButton: true, // 👈 show button only for mobile
                // onCartPressed: () {
                //   // Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute(
                //   //     builder: (_) => const CartView(showBackButton: true),
                //   //   ),
                //   // );
                // },
                showBackButton: true,
              ),
              Expanded(child: state.showCartView ? CartView() : ItemSelector()),
            ],
          );
        },
      ),
    );
  }
}
