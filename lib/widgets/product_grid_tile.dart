import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;

  ProductGridTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        // leading: IconButton(
        //   icon: Icon(Icons.favorite_border),
        //   color: Colors.white,
        //   onPressed: () {},
        // ),
        title: Text(
          product.name,
          style: TextStyle(fontSize: 16.0),
        ),
        subtitle: Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 14.0),
        ),
        trailing: Text(
          'Stock: ${product.stockQuantity}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
