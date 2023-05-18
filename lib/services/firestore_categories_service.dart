import 'package:cloud_firestore/cloud_firestore.dart';

// import '../models/category.dart';

class FirestoreCategoriesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getCategories() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('category').get();
    List<String> categories = [];
    // Preencher a lista de categorias com os dados recuperados
    for (var doc in querySnapshot.docs) {
      print('doc => $doc');
      categories.add(doc['name']);
    }
    return categories;
  }
}
