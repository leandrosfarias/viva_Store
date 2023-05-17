import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addProduct(
      {required String name,
      required double price,
      required category,
      required urlImage,
      required description,
      required stockQuantity}) async {
    // Obter o usuário atual
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        // Adicionar o produto ao Firestore
        await _firestore.collection('products').add({
          'productName': name,
          'price': price,
          'userId': user.uid, // Associar o produto ao usuário
          'category': category,
          'urlImage': urlImage,
          'description': description,
          'stockQuantity': stockQuantity
        });
      } catch (e) {
        // Handle error
        print(e);
      }
    } else {
      print('No user is currently signed in.');
    }
  }
}
