import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frigider_virtual/models/ingredient.dart';
import 'package:frigider_virtual/models/recipe.dart';
import 'package:frigider_virtual/services/auth_service.dart';
import 'package:frigider_virtual/services/users_service.dart';

class RecipeService {
  late CollectionReference<Map<String, dynamic>> _recipes;

  RecipeService() {
    configureDB();
  }

  Future configureDB() async {
    var userEmail = AuthService.getLoggedInUserEmail();
    if (userEmail == null) {
      return;
    }
    String userId = await UsersService.getUserId(userEmail);
    _recipes = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("recipes");
  }

  Future<List<Recipe>> getRecipes() async {
    var recipesDocs = await _recipes.get();
    return recipesDocs.docs.map((recipeDoc) {
      var recipe = Recipe.fromMap(recipeDoc.data());
      recipe.id = recipeDoc.id;
      return recipe;
    }).toList();
  }

  Future<List<Ingredient>> getRecipeIngredients(String recipeId) async {
    var ingredientsDocs =
        await _recipes.doc(recipeId).collection('ingredients').get();
    return ingredientsDocs.docs.map((ingredientDoc) {
      var ingredient = Ingredient.fromMap(ingredientDoc.data());
      ingredient.id = ingredientDoc.id;
      return ingredient;
    }).toList();
  }

  Future<List<Recipe>> getRecipesWithIngredients() async {
    var recipesDocs = await _recipes.get();
    List<Recipe> recipes = <Recipe>[];
    for (var recipeDoc in recipesDocs.docs) {
      var recipe = Recipe.fromMap(recipeDoc.data());
      recipe.id = recipeDoc.id;
      recipe.ingredients = await getRecipeIngredients(recipeDoc.id);
      recipes.add(recipe);
    }
    return recipes;
  }

  Future<Recipe> getRecipeById(String recipeId) async {
    var recipeDoc = await _recipes.doc(recipeId).get();
    var recipe = Recipe.fromMap(recipeDoc.data());
    recipe.id = recipeDoc.id;
    recipe.ingredients = await getRecipeIngredients(recipeId);
    return recipe;
  }

  Future<String> addRecipeIngredient(
      String recipeId, Ingredient ingredient) async {
    var recipeDoc = await _recipes
        .doc(recipeId)
        .collection('ingredients')
        .add(ingredient.toMapWithoutId());
    return recipeDoc.id;
  }

  Future deleteRecipeIngredient(String recipeId, Ingredient ingredient) async {
    await _recipes
        .doc(recipeId)
        .collection('ingredients')
        .doc(ingredient.id)
        .delete();
  }

  Future<String> addRecipe(Recipe recipe) async {
    var recipeDoc = await _recipes.add(recipe.toMapWithoutIdAndIngredients());
    for (var ingredient in recipe.ingredients) {
      await addRecipeIngredient(recipeDoc.id, ingredient);
    }
    return recipeDoc.id;
  }

  Future updateRecipe(Recipe recipe) async {
    if (recipe.id == null) {
      return;
    }
    await _recipes.doc(recipe.id).update(recipe.toMapWithoutIdAndIngredients());
    // the users can remove some ingredients from the recipe,
    // so we need to delete the ingredients that are not in the recipe anymore
    var oldIngredients = await getRecipeIngredients(recipe.id!);
    for (var oldIngredient in oldIngredients) {
      await deleteRecipeIngredient(recipe.id!, oldIngredient);
    }
    // add the new ingredients to the recipe
    for (var ingredient in recipe.ingredients) {
      await addRecipeIngredient(recipe.id!, ingredient);
    }
  }

  Future deleteRecipe(String recipeId) async {
    await _recipes.doc(recipeId).delete();
  }
}
