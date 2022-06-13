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
    db = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('products');
  }

  Future<String> addProduct(ProductItem item) async {
    DocumentReference doc = await db!.add({
      'name': item.getName,
      'description': item.getDescription,
      'category': item.getCategory,
      'purchase_date': Timestamp(item.getPurchaseDate.millisecondsSinceEpoch ~/ 1000, 0),
      'expiration_date': Timestamp(item.getExpireDate.millisecondsSinceEpoch ~/ 1000, 0),
      'quantity': num.parse(item.getQuantity),
      'quantity_measure': item.getMeasurement,
      'number_of_products':
          num.parse(item.getAmount == "" ? "1" : item.getAmount)
    });
    return doc.id;
  }

  Future updateProduct(ProductItem item) async {
    await db!.doc(item.id).update({
      'name': item.getName,
      'description': item.getDescription,
      'category': item.getCategory,
      'purchase_date': Timestamp(item.getPurchaseDate.millisecondsSinceEpoch ~/ 1000, 0),
      'expiration_date': Timestamp(item.getExpireDate.millisecondsSinceEpoch ~/ 1000, 0),
      'quantity': num.parse(item.getQuantity),
      'quantity_measure': item.getMeasurement,
      'number_of_products':
          num.parse(item.getAmount == "" ? "1" : item.getAmount)
    });
  }

  Future deleteProduct(ProductItem item) async {
    await db!.doc(item.id).delete();
  }

  Future<List<ProductItem>> getProducts() async {
    return await Future.delayed(const Duration(milliseconds: 1000), () {
      return db!.get().then((values) {
        List<ProductItem> products = <ProductItem>[];
        for (var value in values.docs) {
          var data = value.data();
          products.add(ProductItem(
            data['name'],
            data['description'],
            data['quantity'].toString(),
            data['quantity_measure'],
            data['number_of_products'].toString(),
            data['category'],
            DateTime.fromMillisecondsSinceEpoch(data['expiration_date'].millisecondsSinceEpoch),
            DateTime.fromMillisecondsSinceEpoch(data['purchase_date'].millisecondsSinceEpoch),
            isExpanded: false,
            focus: false,
          ));
          products.last.setId = value.id;
        }
        return products;
      });
    });
  }
}
