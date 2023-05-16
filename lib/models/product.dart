class Product {
  String name; // Name of the product
  String description; // Description of the product
  double price; // Price of the product
  String imageUrl; // URL of the product image
  String categoryId; // The id of the category this product belongs to
  bool isAvailable; // Availability of the product
  int stockQuantity; // Number of products in stock

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.isAvailable = false,
    this.stockQuantity = 0,
  });

  static List<Product> getProductsByCategory() {
    return [
      Product(
        name: 'Product 1',
        description: 'This is product 1',
        price: 19.99,
        imageUrl: 'https://via.placeholder.com/150',
        categoryId: 'tshirt',
        isAvailable: true,
        stockQuantity: 20,
      ),
    ].toList();
  }
// static List<Product> getProductsByCategory(String categoryId) {
//   List<Product> mockProducts = [
//     Product(
//       // id: '1',
//       name: 'Product 1',
//       description: 'This is product 1',
//       price: 19.99,
//       imageUrl: 'https://via.placeholder.com/150',
//       categoryId: 'tshirt',
//       isAvailable: true,
//       stockQuantity: 20,
//     ),
//     Product(
//       // id: '2',
//       name: 'Product 1',
//       description: 'This is product 2',
//       price: 29.99,
//       imageUrl: 'https://via.placeholder.com/150',
//       categoryId: 'paintBrush',
//       isAvailable: true,
//       stockQuantity: 15,
//     ),
//     Product(
//       // id: '1',
//       name: 'Product 2',
//       description: 'This is product 2',
//       price: 19.99,
//       imageUrl: 'https://via.placeholder.com/150',
//       categoryId: 'tshirt',
//       isAvailable: true,
//       stockQuantity: 20,
//     ),
//     Product(
//       // id: '1',
//       name: 'Product 3',
//       description: 'This is product 3',
//       price: 19.99,
//       imageUrl: 'https://via.placeholder.com/150',
//       categoryId: 'tshirt',
//       isAvailable: true,
//       stockQuantity: 20,
//     ),
//     Product(
//       // id: '1',
//       name: 'Product 4',
//       description: 'This is product 4',
//       price: 19.99,
//       imageUrl: 'https://via.placeholder.com/150',
//       categoryId: 'tshirt',
//       isAvailable: true,
//       stockQuantity: 20,
//     ),
//     Product(
//       // id: '1',
//       name: 'Product 5',
//       description: 'This is product 5',
//       price: 19.99,
//       imageUrl: 'https://via.placeholder.com/150',
//       categoryId: 'tshirt',
//       isAvailable: true,
//       stockQuantity: 20,
//     ),
//     // Add more products
//   ];
//
//   return mockProducts
//       .where((product) => product.categoryId == categoryId)
//       .toList();
// }
}
