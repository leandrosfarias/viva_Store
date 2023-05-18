import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name; // Name of the product
  String description; // Description of the product
  double price; // Price of the product
  String imageUrl; // URL of the product image
  bool isAvailable; // Availability of the product
  int stockQuantity; // Number of products in stock

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isAvailable = false,
    this.stockQuantity = 0,
  });

  static Future<List<Product>> getProductsByCategory(String category) async {
    print('CATEGORIA => ${category}');
    try {
      // print('CATEGORIA => ${category}');
      List<Product> products = [];
      // Obter a lista de categorias do Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
      // Preencher a lista de categorias com os dados recuperados
      print('querySnapshot.docs.length => ${querySnapshot.docs.length}');
      for (var doc in querySnapshot.docs) {
        Product product = Product(
          id: doc['id'],
          name: doc['productName'],
          description: doc['description'],
          price: doc['price'],
          imageUrl: doc['urlImage'],
          stockQuantity: doc['stockQuantity'],
        );
        print('VAI ADICIONAR!!!');
        print(product.toString());
        products.add(product);
      }
      print('TAMANHO DA LISTA => ${products.length}');
      return products;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  String toString() {
    return 'produto: {preço: $price}';
  }
}
