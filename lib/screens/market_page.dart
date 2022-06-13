import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frigider_virtual/models/market_recipe.dart';
import 'package:frigider_virtual/services/market_recipes_service.dart';
import 'package:frigider_virtual/services/recipes_service.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  late List<MarketRecipe> _marketRecipes = <MarketRecipe>[];
  final MarketRecipesService _marketRecipesService = MarketRecipesService();
  final RecipesService _recipesService = RecipesService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getMarketRecipes();
    });
  }

  _getMarketRecipes() async {
    _marketRecipes = await _marketRecipesService.getMarketRecipes();
    setState(() => _marketRecipes);

    // todo examples to use the service - remove later
    // print('\n######################\n');
    // // ? get all market recipes with ingredients
    // var marketRecipes =
    //     await _marketRecipesService.getMarketRecipesWithIngredients();
    // print('marketRecipes: $marketRecipes');
    // print(marketRecipes[0].toMap());
    // print(marketRecipes[0].ingredients[0].toMap());

    // // ? get only a market recipe
    // var marketRecipe =
    //     await _marketRecipesService.getMarketRecipeById('p20W3LU61kV0L6kxNjZm');
    // print(marketRecipe);
    // print(marketRecipe.toMap());
    // print(marketRecipe.ingredients[0].toMap());

    // var recipe = await _recipeService.getRecipeById('FPaPR1h6vHWKgIxsBMDU');
    // var userId =
    //     await UsersService.getUserId(AuthService.getLoggedInUserEmail()!);
    // var createdBy = await UsersService.getUserReferenceByEmail(
    //     AuthService.getLoggedInUserEmail()!);
    // print('createdBy: $createdBy');
    // print(recipe.toMap());
    // var newMarketRecipe = MarketRecipe.fromRecipe(recipe, createdBy);
    // var marketRecipeId =
    //     await _marketRecipesService.addMarketRecipe(newMarketRecipe);
    // print('marketRecipeId: $marketRecipeId');
    // var marketRecipe2 =
    //     await _marketRecipesService.getMarketRecipeById(marketRecipeId);
    // print('marketRecipe: $marketRecipe');
    // print(marketRecipe2.toMap());
    // marketRecipe2.name = "new_recipe_name";
    // marketRecipe2.ingredients[0].name = "new_ingredient_name";
    // marketRecipe2.ingredients[1].quantity = 420;
    // await _marketRecipesService.updateMarketRecipe(marketRecipe2);
    // await _marketRecipesService.deleteMarketRecipe(marketRecipe2.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<MarketRecipe?>(
      future: readMarketRecipe(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("snapshot error");
        } else if (snapshot.hasData) {
          final marketRecipe = snapshot.data;
          return marketRecipe == null
              ? Center(child: Text('no recipe'))
              : buildMarketRecipe(marketRecipe);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }

  Widget buildMarketRecipe(MarketRecipe marketRecipe) {
    return ListTile(
      leading: CircleAvatar(child: Text('${marketRecipe.description}')),
      title: Text(marketRecipe.name),
      subtitle: Text(marketRecipe.getPreparationTime),
    );
  }

  Stream<List<MarketRecipe>> readMarketRecipes() => FirebaseFirestore.instance
      .collection('market_recipes')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => MarketRecipe.fromMap(doc.data()))
          .toList());

  Future<MarketRecipe?> readMarketRecipe() async {
    final docMarketRecipes = FirebaseFirestore.instance
        .collection('market_recipe')
        .doc('p20W3LU61kV0L6kxNjZm');
    final snapshot = await docMarketRecipes.get();

    if (snapshot.exists) {
      return MarketRecipe.fromMap(snapshot.data()!);
    }
  }
}
