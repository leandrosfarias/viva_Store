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
        DocumentReference docRef = await _firestore.collection('products').add({
          'productName': name,
          'price': price,
          'userId': user.uid, // Associar o produto ao usuário
          'category': category,
          'urlImage': urlImage,
          'description': description,
          'stockQuantity': stockQuantity,
          'id': '', // placeholder para o id do documento
        });
        // Atualizar o documento recém-criado com o seu próprio id
        await docRef.update({'id': docRef.id});
      } catch (e) {
        // Handle error
        print(e);
      }
    } else {
      print('No user is currently signed in.');
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      return true;
    } catch (e) {
      // Handle error
      print(e);
      return false;
    }
  }
}
