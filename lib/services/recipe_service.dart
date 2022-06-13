import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/recipe.dart';

class RecipesService {
  static final _recipes = FirebaseFirestore.instance.collection('recipes');

  static Future<void> addRecipe(Recipe recipe) async {
    await _recipes.add(recipe.toMapWithoutId()).then((value) {
      if (kDebugMode) {
        print('Recipe added');
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Error adding recipe: $error');
      }
    });
  }

  static Future<String> getaddRecipeId(String name) async {
    return _recipes.where('name', isEqualTo: name).get().then((value) {
      return value.docs[0].id;
    });
  }

  static Future<Recipe?> getRecipeByName(String name) async {
    return _recipes.where('name', isEqualTo: name).get().then((value) {
      var recipeMap = value.docs[0].data();
      recipeMap['id'] = value.docs[0].id;
      return Future<Recipe?>.value(Recipe.fromMap(recipeMap));
    }).catchError((error) {
      if (kDebugMode) {
        print('Error while getting recipe by name: $error');
      }
      return Future<Recipe?>.value(null);
    });
  }
}
