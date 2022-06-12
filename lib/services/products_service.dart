import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frigider_virtual/models/product_item.dart';
import 'package:frigider_virtual/services/users_service.dart';

class ProductsService {

  late CollectionReference<Map<String, dynamic>>? db;

  ProductsService() {
    getDB();
  }

  Future getDB() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return null;
    }
    var userEmail = currentUser.email;
    if (userEmail == null) {
      return null;
    }

    String userId = await UsersService.getUserId(userEmail);
    db = FirebaseFirestore.instance.collection('users').doc(userId).collection('products');
  }

  Future<String> addProduct(ProductItem item) async {
    DocumentReference doc = await db!.add({
      'name': item.getName,
      'description': item.getDescription,
      'category': item.getCategory,
      'purchase_date': item.getPurchaseDate.millisecondsSinceEpoch,
      'expiration_date': item.getExpireDate.millisecondsSinceEpoch,
      'quantity': num.parse(item.getQuantity),
      'quantity_measure': item.getMeasurement,
      'number_of_products': num.parse(item.getAmount == "" ? "1" : item.getAmount)
    });
    return doc.id;
  }

  Future updateProduct(ProductItem item) async {
    await db!.doc(item.id).update({
      'name': item.getName,
      'description': item.getDescription,
      'category': item.getCategory,
      'purchase_date': item.getPurchaseDate.millisecondsSinceEpoch,
      'expiration_date': item.getExpireDate.millisecondsSinceEpoch,
      'quantity': num.parse(item.getQuantity),
      'quantity_measure': item.getMeasurement,
      'number_of_products': num.parse(item.getAmount == "" ? "1" : item.getAmount)
    });
  }

  Future deleteProduct(ProductItem item) async {
    await db!.doc(item.id).delete();
  }
}