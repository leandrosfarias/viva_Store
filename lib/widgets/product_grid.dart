import 'package:flutter/material.dart';
import 'package:viva_store/widgets/product_card.dart';

import '../models/product.dart';

class ProductGrid extends StatelessWidget {
  final String category;

  const ProductGrid({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: Product.getProductsByCategory(category),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Product> products = snapshot.data ?? [];
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        }
      },
    );
  }
}
