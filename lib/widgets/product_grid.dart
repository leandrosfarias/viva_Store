import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viva_store/providers/productProvider.dart';
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
    // print('loadProducts FOI CHAMADO !');
    futureProducts = Product.getProductsByCategory(widget.category);
    // futureProducts.then((List<Product> products) {
    //   for (Product product in products){
    //     print('product.id  NO GRID => ${product.id}');
    //   }
    // });
  }

  void removeProduct(String productId) async {
    print('Estou tentando deletar produto, cujo id é => $productId');
    bool deletionSucessful = await productService.deleteProduct(productId);
    if (deletionSucessful) {
      print('Produto deletado com sucesso!');
      //
      setState(() {
        loadProducts();
      });
    } else {
      print('Falha ao deletar produto!');
    }
  }

  void updateProduct(Product product) async {
    print('updateProduct FOI CHAMADO !');
    bool updateSucessful = await productService.updateProduct(product);
    if (updateSucessful) {
      // print('Produto atualizado com sucesso! ${product.imageUrl}');
      //
      setState(() {
        print('updateProduct foi reconstruído');
        loadProducts();
      });
    } else {
      print('Falha ao atualizado produto!');
    }
  }

  @override
  void initState() {
    // print('ESTOU SENDO CRIADO!');
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) => GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: productProvider.products
            .where((product) => product.category == widget.category)
            .length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 5,
          crossAxisSpacing: 6,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ProductCard(
            product: productProvider.products
                .where((product) => product.category == widget.category)
                .toList()[index],
            onProductDeleted: productProvider.deleteProduct,
            onProductUpdate: productProvider.updateProduct,
          );
        },
      ),
    );
  }
}
