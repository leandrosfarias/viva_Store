import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viva_store/config/color_palette.dart';
import 'package:viva_store/screens/product_management.dart';

class CategoryManagement extends StatelessWidget {
  final List<String> categories = [
    'Vestuário',
    'Decoração',
    'Beleza',
    'Cama',
    'Mesa',
    'Banho'
  ];

  CategoryManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: const Text('Category Management'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: categories.length,
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductManagement(categoryId: categories[index])));
            },
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black12,
                leading: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    // Navigate to the Edit Category screen
                  },
                ),
                title: const Text(''),
              ),
              child: Container(
                color: ColorPalette.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      _getIconData(categories[index]),
                      color: Colors.white,
                      size: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      categories[index],
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          // Navigate to the Add Category screen
        },
      ),
    );
  }

  IconData _getIconData(String category) {
    switch (category) {
      case 'Vestuário':
        return FontAwesomeIcons.tshirt;
      case 'Decoração':
        return FontAwesomeIcons.paintBrush;
      case 'Beleza':
        return FontAwesomeIcons.spa;
      case 'Cama':
        return FontAwesomeIcons.bed;
      case 'Mesa':
        return FontAwesomeIcons.table;
      case 'Banho':
        return FontAwesomeIcons.bath;
      default:
        return FontAwesomeIcons.box; // Default icon if category is not found
    }
  }
}
