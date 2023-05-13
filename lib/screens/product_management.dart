import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viva_store/config/color_palette.dart';
import 'package:viva_store/widgets/product_grid_tile.dart';

import '../models/product.dart';

final List<IconData> icons = [
  FontAwesomeIcons.tshirt,
  FontAwesomeIcons.paintBrush,
  FontAwesomeIcons.spa,
  FontAwesomeIcons.bed,
  FontAwesomeIcons.table,
  FontAwesomeIcons.bath,
  // FontAwesomeIcons.box
];

final List<Product> products = [
  Product(
    imageUrl: 'https://url.to/your/image1.jpg',
    name: 'Product 1',
    price: 59.99,
    stockQuantity: 10,
    id: '1',
    description: 'descrição',
    categoryId: '1',
  ),
  Product(
    imageUrl: 'https://url.to/your/image2.jpg',
    name: 'Product 2',
    price: 79.99,
    stockQuantity: 5,
    id: '1',
    description: 'descrição',
    categoryId: '1',
  ),
  // Add more products as needed
];

class ProductManagement extends StatelessWidget {
  final String categoryId;

  const ProductManagement({Key? key, required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: const Text('Gerenciamento de produtos'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1, // Define que a primeira linha ocupa 10% da tela
            child: Container(
              // color: Colors.blue,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: icons.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(7.0),
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icons[index],
                        size: 20.0,
                        color: Colors.white,
                      ),
                    );
                  }),
              // Conteúdo da primeira linha
            ),
          ),
          Expanded(
            flex: 9, // Define que a segunda linha ocupa o restante (90%)
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height /
                        1.8), // Width:Height ratio of items
                crossAxisSpacing: 15, // Horizontal spacing
                mainAxisSpacing: 8, // Vertical spacing
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {},
                    child: ProductGridTile(product: products[index]));
              },
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     // Navigate to the Add Product screen
      //   },
      // ),
    );
  }
}
