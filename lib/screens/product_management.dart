import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viva_store/config/color_palette.dart';
import 'package:viva_store/services/firestore_product_service.dart';
import 'package:viva_store/widgets/product_grid.dart';

import '../models/product.dart';
import 'add_product.dart';

class ProductManagement extends StatefulWidget {
  final FirestoreProductService _firestoreProductService =
      FirestoreProductService();

  ProductManagement({Key? key}) : super(key: key);

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  // final List<Product> _products = [];

  void _addProduct() {
    print('_addProduct esta sendo chamado');
    setState(() {
      print('E esta reconstruindo ProductManagement');
      // _products.add(product);
    });
  }

  void _updateProduct(Product product) {
    print(
        'Vou atualizar um produto chamando _updateProduct de ProductManagment');
    widget._firestoreProductService.updateProduct(product);
  }

  void _deleteProduct(String productId) {
    print('Vou deletar um produto chamando _deleteProduct de ProductManagment');
    widget._firestoreProductService.deleteProduct(productId);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorPalette.primaryColor,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.tshirt),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.paintBrush),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.spa),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.bed),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.table),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.bath),
                ),
              ],
              isScrollable: true,
            ),
            title: const Text('Estoque'),
          ),
          body: Container(
            color: ColorPalette.backgroundColor,
            child: TabBarView(
              children: [
                ProductGrid(
                    category: 'vestuario',
                    onDeleteProduct: _deleteProduct,
                    onUpdateProduct: _updateProduct),
                ProductGrid(
                    category: 'decoracao',
                    onDeleteProduct: _deleteProduct,
                    onUpdateProduct: _updateProduct),
                ProductGrid(
                    category: 'beleza',
                    onDeleteProduct: _deleteProduct,
                    onUpdateProduct: _updateProduct),
                ProductGrid(
                    category: 'cama',
                    onDeleteProduct: _deleteProduct,
                    onUpdateProduct: _updateProduct),
                ProductGrid(
                    category: 'mesa',
                    onDeleteProduct: _deleteProduct,
                    onUpdateProduct: _updateProduct),
                ProductGrid(
                    category: 'banho',
                    onDeleteProduct: _deleteProduct,
                    onUpdateProduct: _updateProduct),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => AddProductPage(_addProduct)),
              );
            },
            backgroundColor: ColorPalette.secondaryColor,
            child: const Icon(Icons.add),
          ),
        ));
  }
}
