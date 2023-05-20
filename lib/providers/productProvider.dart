import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:viva_store/services/firestore_product_service.dart';

import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];

  final FirestoreProductService _firestoreProductService =
      FirestoreProductService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProductProvider() {
    fetchProducts();
  }

  List<Product> get products => _products;

  void addProduct(Product product) {
    _firestoreProductService.addProduct(
        name: product.name,
        price: product.price,
        category: product.category,
        urlImage: product.imageUrl,
        description: product.description,
        stockQuantity: product.stockQuantity);
    // adiciona o mesmo produto na lista
    _products.add(product);
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    print('updateProduct de ProductProvider foi chamado');
    // atualiza na base
    await _firestoreProductService.updateProduct(product);
    // pega o indice do elemento que precisa ser atualizado
    int index = _products.indexWhere((p) => p.id == product.id);
    // sobrepõe o elemento com o novo objeto Produto
    print(
        'Nome do produto atualizado, talvez o novo nome seja => ${product.name}');
    _products[index] = product;
    notifyListeners();
  }

  void deleteProduct(String productId) {
    _firestoreProductService.deleteProduct(productId);
    _products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  void fetchProducts() async {
    print('fetchProducts de productProvider foi chamado');
    QuerySnapshot querySnapshot = await _firestore.collection('products').get();
    print('querySnapshot.docs.length => ${querySnapshot.docs.length}');
    for (var doc in querySnapshot.docs) {
      print('product.name => ${doc['name']}');
      _products.add(Product(
        id: doc['id'],
        name: doc['name'],
        category: doc['category'],
        description: doc['description'],
        price: doc['price'],
        imageUrl: doc['urlImage'],
        stockQuantity: doc['stockQuantity'],
      ));
    }
    notifyListeners();
    // _firestore.collection('products').snapshots().listen((snapshot) {
    //   for (var doc in snapshot.docs) {
    //     _products.add(Product(
    //       id: doc['id'],
    //       name: doc['name'],
    //       category: doc['category'],
    //       description: doc['description'],
    //       price: doc['price'],
    //       imageUrl: doc['urlImage'],
    //       stockQuantity: doc['stockQuantity'],
    //     ));
    //   }
    //
    //   notifyListeners();
    // });
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    // Obter a lista de produtos filtrando por categoria do Firestore
    QuerySnapshot querySnapshot = await _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .get();

    for (var doc in querySnapshot.docs) {
      _products.add(Product(
        id: doc['id'],
        name: doc['name'],
        category: doc['category'],
        description: doc['description'],
        price: doc['price'],
        imageUrl: doc['urlImage'],
        stockQuantity: doc['stockQuantity'],
      ));
    }
    notifyListeners();
    return _products;
  }
}
