import 'package:flutter/material.dart';
import 'package:viva_store/widgets/product_card.dart';

import '../models/product.dart';
import '../services/firestore_product_service.dart';

class ProductGrid extends StatefulWidget {
  final String category;

  const ProductGrid({Key? key, required this.category}) : super(key: key);

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  late Future<List<Product>> futureProducts;
  final FirestoreProductService productService = FirestoreProductService();

  void loadProducts() {
    print('FUI CHAMADO !');
    futureProducts = Product.getProductsByCategory(widget.category);
    futureProducts.then((List<Product> products) {
      for (Product product in products){
        print('product.id => ${product.id}');
      }
    });
  }

  void removeProduct(Product product) async {
    print('ESTOU TENTANDO DELETAR!');
    bool deletionSucessful = await productService.deleteProduct(product.id);
    if (deletionSucessful) {
      print('Produto deletado com sucesso!');
      setState(() {
        loadProducts();
      });
    } else {
      print('Falha ao deletar produto!');
    }
  }

  @override
  void initState() {
    print('ESTOU SENDO CRIADO!');
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: futureProducts,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          print('ESTOU POR AQUI !!!');
          List<Product> products = snapshot.data ?? [];
          print('tamanho da lista de produtos => ${products.length}');
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 5,
              crossAxisSpacing: 6,
              mainAxisSpacing: 100000,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: products[index],
                onProductDeleted: removeProduct,
              );
            },
          );
        }
      },
    );
  }
}
