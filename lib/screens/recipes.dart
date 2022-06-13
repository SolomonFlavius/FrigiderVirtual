import 'package:flutter/material.dart';
import 'package:frigider_virtual/models/recipe.dart';
import 'package:frigider_virtual/services/recipes_service.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  late List<Recipe> _recipes = <Recipe>[];
  final RecipesService _recipesService = RecipesService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getRecipes();
    });
  }

  _getRecipes() async {
    _recipes = await _recipesService.getRecipesWithIngredients();
    setState(() => _recipes);
    // todo examples to use the service - remove later
    // print("\n#########\n");
    // print(recipes);
    // print(recipes[0].toMap());
    // print(recipes[0].ingredients);
    // print(recipes[0].ingredients[0].toMap());
    // var ingredients = <Ingredient>[];
    // ingredients.add(recipes[0].ingredients[0]);
    // var recipe = Recipe(null, "recipe_name", "description", 215900,
    //     Timestamp.now(), Timestamp.now(), ingredients);
    // var recipeId = await _recipeService.addRecipe(recipe);
    // recipe = await _recipeService.getRecipeById(recipeId);
    // recipe.name = "new_recipe_name";
    // recipe.ingredients[0].name = "new_ingredient_name";
    // recipe.ingredients[1].quantity = 420;
    // await _recipeService.updateRecipe(recipe);
    // await _recipeService.deleteRecipe("bGSGF51iAey5sZQIiCLr");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: Center(
        child: Text('Recipes'),
      ),
    );
  }
}
