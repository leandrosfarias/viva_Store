import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viva_store/providers/productProvider.dart';
import 'package:viva_store/widgets/product_card.dart';

import '../models/product.dart';
import '../services/firestore_product_service.dart';

class ProductGrid extends StatefulWidget {
  final String category;
  final Function(String) onDeleteProduct;
  final Function(Product product) onUpdateProduct;

  const ProductGrid(
      {Key? key,
      required this.category,
      required this.onDeleteProduct,
      required this.onUpdateProduct})
      : super(key: key);

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  late Future<List<Product>> futureProducts;
  final FirestoreProductService productService = FirestoreProductService();
  final double itemWidth = 200;
  final ProductProvider productProvider = ProductProvider();

  @override
  void initState() {
    print('productGrid esta sendo criado');
    super.initState();
    // productProvider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var crossAxisCount = (screenWidth / itemWidth).floor();
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data!.docs
              .map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return Product(
                    id: doc.id,
                    name: data['name'],
                    category: data['category'],
                    description: data['description'],
                    price: data['price'],
                    imageUrl: data['urlImage'],
                    stockQuantity: data['stockQuantity']
                    // ... adicione outras propriedades do produto
                    );
              })
              // filtrando por categoria
              .where((element) => element.category == widget.category)
              .toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 3 / 4.9,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                  product: product,
                  onProductDeleted: widget.onDeleteProduct,
                  onProductUpdate: widget.onUpdateProduct);
            },
          );
        } else if (snapshot.hasError) {
          return Text('Erro ao carregar produtos');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
