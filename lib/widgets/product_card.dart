import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    print('será que vou renderizar?');
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 18.0 / 15.0,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Preço: R\$ ${product.price.toStringAsFixed(2).toString()}',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Estoque: ${product.stockQuantity.toString()}',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
