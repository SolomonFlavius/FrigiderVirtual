import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frigider_virtual/models/ingredient.dart';
import 'package:frigider_virtual/models/market_recipe.dart';

class MarketRecipesService {
  final _marketRecipes =
      FirebaseFirestore.instance.collection('market_recipes');

  Future<List<Ingredient>> getMarketRecipeIngredients(
      String marketRecipeId) async {
    var ingredientsDocs = await _marketRecipes
        .doc(marketRecipeId)
        .collection('ingredients')
        .get();
    return ingredientsDocs.docs.map((ingredientDoc) {
      var ingredient = Ingredient.fromMap(ingredientDoc.data());
      ingredient.id = ingredientDoc.id;
      return ingredient;
    }).toList();
  }

  Future<MarketRecipe> getMarketRecipeById(String marketRecipeId) async {
    var marketRecipeDoc = await _marketRecipes.doc(marketRecipeId).get();
    var marketRecipe = MarketRecipe.fromMap(marketRecipeDoc.data());
    marketRecipe.id = marketRecipeDoc.id;
    marketRecipe.ingredients =
        await getMarketRecipeIngredients(marketRecipeDoc.id);
    return marketRecipe;
  }

  Future<List<MarketRecipe>> getMarketRecipes() async {
    var marketRecipesDocs = await _marketRecipes.get();
    List<MarketRecipe> marketRecipes = <MarketRecipe>[];
    for (var marketRecipeDoc in marketRecipesDocs.docs) {
      var marketRecipe = MarketRecipe.fromMap(marketRecipeDoc.data());
      marketRecipe.id = marketRecipeDoc.id;
      marketRecipes.add(marketRecipe);
    }
    return marketRecipes;
  }

  Future<List<MarketRecipe>> getMarketRecipesWithIngredients() async {
    var marketRecipesDocs = await _marketRecipes.get();
    List<MarketRecipe> marketRecipes = <MarketRecipe>[];
    for (var marketRecipeDoc in marketRecipesDocs.docs) {
      var marketRecipe = MarketRecipe.fromMap(marketRecipeDoc.data());
      marketRecipe.id = marketRecipeDoc.id;
      marketRecipe.ingredients =
          await getMarketRecipeIngredients(marketRecipeDoc.id);
      marketRecipes.add(marketRecipe);
    }
    return marketRecipes;
  }

  Future<String> addMarketRecipeIngredient(
      String marketRecipeId, Ingredient ingredient) async {
    var ingredientDoc = await _marketRecipes
        .doc(marketRecipeId)
        .collection('ingredients')
        .add(ingredient.toMapWithoutId());
    return ingredientDoc.id;
  }

  Future deleteMarketRecipeIngredient(
      String marketRecipeId, Ingredient ingredient) async {
    await _marketRecipes
        .doc(marketRecipeId)
        .collection('ingredients')
        .doc(ingredient.id)
        .delete();
  }

  Future<String> addMarketRecipe(MarketRecipe marketRecipe) async {
    var recipeDoc =
        await _marketRecipes.add(marketRecipe.toMapWithoutIdAndIngredients());
    for (var ingredient in marketRecipe.ingredients) {
      await addMarketRecipeIngredient(recipeDoc.id, ingredient);
    }
    return recipeDoc.id;
  }

  Future updateMarketRecipe(MarketRecipe marketRecipe) async {
    if (marketRecipe.id == null) {
      return;
    }
    await _marketRecipes
        .doc(marketRecipe.id)
        .update(marketRecipe.toMapWithoutIdAndIngredients());
    // the users can remove some ingredients from the recipe,
    // so we need to delete the ingredients that are not in the recipe anymore
    var oldIngredients = await getMarketRecipeIngredients(marketRecipe.id!);
    for (var oldIngredient in oldIngredients) {
      await deleteMarketRecipeIngredient(marketRecipe.id!, oldIngredient);
    }
    // add the new ingredients to the recipe
    for (var ingredient in marketRecipe.ingredients) {
      await addMarketRecipeIngredient(marketRecipe.id!, ingredient);
    }
  }

  Future deleteMarketRecipe(String marketRecipeId) async {
    await _marketRecipes.doc(marketRecipeId).delete();
  }
}
