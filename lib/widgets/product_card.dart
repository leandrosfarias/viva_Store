import 'package:flutter/material.dart';
import 'package:viva_store/screens/update_product_screen.dart';

import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(String) onProductDeleted;
  final Function(Product) onProductUpdate;

  ProductCard(
      {required this.product,
      required this.onProductDeleted,
      required this.onProductUpdate});

  @override
  Widget build(BuildContext context) {
    // print('ID DO PRODUTO NO CARD => ${product.id}');
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
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateProductScreen(
                                        product: product,
                                    updateProduct: onProductUpdate,
                                      )))
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 25,
                        ),
                        color: Colors.white,
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () => {
                          print('Botão de deletar pressionado'),
                          print('Em card, product.name é => ${product.name}'),
                          onProductDeleted(product.id)
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 25,
                        ),
                        color: Colors.white,
                      ),
                    )
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
