import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viva_store/config/color_palette.dart';
import 'package:viva_store/widgets/product_grid.dart';

import '../models/product.dart';
import 'add_product.dart';

class ProductManagement extends StatefulWidget {
  const ProductManagement({Key? key}) : super(key: key);

  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  final List<Product> _products = [];

  void _addProduct(Product product) {
    setState(() {
      _products.add(product);
    });
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
            child: const TabBarView(
              children: [
                ProductGrid(category: 'vestuario'),
                ProductGrid(category: 'decoracao'),
                ProductGrid(category: 'beleza'),
                ProductGrid(category: 'cama'),
                ProductGrid(category: 'mesa'),
                ProductGrid(category: 'banho'),
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
            child: const Icon(
                Icons.add),
          ),
        ));
  }
}
