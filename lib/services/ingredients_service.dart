import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frigider_virtual/models/product_item.dart';
import 'package:frigider_virtual/services/users_service.dart';

import '../models/recipe.dart';

class IngredientsService {
  late CollectionReference<Map<String, dynamic>>? db;

  IngredientsService() {
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
        .collection('recipes')
        .doc()
        .collection('ingredientes');
  }

  Future<String> addIngredient(Ingredients item) async {
    DocumentReference doc = await db!.add({
      'name': item.getName,
      'quantity': item.getQuantity,
      'quantity_measure': item.getQuantityMeasure,
    });
    return doc.id;
  }

  Future updateIngredientt(Ingredients item) async {
    await db!.doc(item.id).update({
      'name': item.getName,
      'quantity': item.getQuantity,
      'quantity_measure': item.getQuantityMeasure,
    });
  }

  Future deleteIngredient(Recipe item) async {
    await db!.doc(item.id).delete();
  }

  Future<List<Ingredients>> getIngredients() async {
    return await Future.delayed(const Duration(milliseconds: 40), () {
      return db!.get().then((values) {
        List<Ingredients> ingredients = <Ingredients>[];
        for (var value in values.docs) {
          var data = value.data();
          ingredients.add(Ingredients(
            data['name'],
            data['quantity'],
            data['quantity_measure'],
          ));
          ingredients.last.setId = value.id;
        }
        return ingredients;
      });
    });
  }
}
