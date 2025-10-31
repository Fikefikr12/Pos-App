import 'package:flutter/material.dart';
import 'package:my_web_app/model/productModel.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DemoCard extends StatelessWidget {
  final Product product;
  const DemoCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      child: Column(
        children: [
          Image(
            image: AssetImage(product.image),
            height: 80,
            fit: BoxFit.cover,
          ),
        ],
      ),
      footer: Text(product.name),
      trailing: ShadButton(child: Text("${product.cartQt}")),
    );
  }
}
