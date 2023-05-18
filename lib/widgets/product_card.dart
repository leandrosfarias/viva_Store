import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/firestore_product_service.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product) onProductDeleted;

  ProductCard({required this.product, required this.onProductDeleted});

  @override
  Widget build(BuildContext context) {
    print('ID DO PRODUTO => ${product.id}');
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
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
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Adicione a lógica para atualizar o produto aqui
                      },
                      child: const Text('Atualizar'),
                    ),
                    ElevatedButton(
                      onPressed: () => onProductDeleted(product),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // This is the color you want
                      ),
                      child: const Text('Deletar'),
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
