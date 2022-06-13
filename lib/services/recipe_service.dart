import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:frigider_virtual/models/product_item.dart';
import 'package:frigider_virtual/services/users_service.dart';


import '../models/recipe.dart';

class RecipesService {
  late CollectionReference<Map<String, dynamic>>? db;

  RecipesService() {
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
        .collection('recipes');
  }

  Future<String> addRecipe(Recipe item) async {
    DocumentReference doc = await db!.add({
      'name': item.getName,
      'description': item.getDescription,
      'preparation_time': item.getPreparationTime,
      'created_at': item.getCreatedAt,
      'updated_at': item.getUpdatedAt,
      'ingrediente': item.getIngredients,
    });
    return doc.id;
  }

  Future updateRecipe(Recipe item) async {
    await db!.doc(item.id).update({
      'name': item.getName,
      'description': item.getDescription,
      'preparation_time': item.getPreparationTime,
      'created_at': item.getCreatedAt,
      'updated_at': item.getUpdatedAt,
      'ingrediente': item.getIngredients,
    });
  }

  Future deleteRecipe(Recipe item) async {
    await db!.doc(item.id).delete();
  }

  Future<List<Recipe>> getRecipe() async {
    return await Future.delayed(const Duration(milliseconds: 40), () {
      return db!.get().then((values) {
        List<Recipe> recipe = <Recipe>[];
        for (var value in values.docs) {
          var data = value.data();
          recipe.add(Recipe(
              data['name'],
              data['description'],
              data['preparationTime'],
              data['createdAt'],
              data['updatedAt'],
              data['ingrediente']));
          recipe.last.setId = value.id;
        }
        return recipe;
      });
    });
  }
}
