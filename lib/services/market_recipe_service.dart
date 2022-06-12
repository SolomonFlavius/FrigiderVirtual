import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/market_recipe.dart';

class MarketRecipeService {
  static final _market_recipes = FirebaseFirestore.instance.collection('market_recipes');

  static Future<void> addRecipeToMarket(MarketRecipe marketRecipe) async {
    await _market_recipes.add(marketRecipe.toMapWithoutId()).then((value) {
      if (kDebugMode) {
        print('Recipe added to market');
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Error adding recipe to market: $error');
      }
    });
  }


}