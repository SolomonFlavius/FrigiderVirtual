import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'dart:collection';
import 'package:intl/intl.dart';

import '../main.dart';
import '../models/ingredient.dart';
import 'show_recipe.dart';

import '../services/recipes_service.dart';
import '../../models/recipe.dart';
import '../services/recipes_service.dart';

List<String> recipesName = [];
List<String> description = [];
List<String> product = [];
List<int> preparationTime = [];
List<int> quantity = [];

class AddRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
                body: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color(0x665ac18e),
                          Color(0x995ac18e),
                          Color(0xcc5ac18e),
                          Color(0xff5ac18e),
                        ])),
                    child: AddRecipeForm()))));
  }
}

class AddRecipeForm extends StatefulWidget {
  const AddRecipeForm({super.key});

  @override
  _AddRecepieForm1 createState() => _AddRecepieForm1();
}

class _AddRecepieForm1 extends State<AddRecipeForm> {
  _AddRecepieForm1() {}

  final recipeController = TextEditingController();
  final productController = TextEditingController();
  final quantityController = TextEditingController();

  final descriptionController = TextEditingController();
  final preparationTimeController = TextEditingController();

  void disposeRecepie() {
    // Clean up the controller when the widget is disposed.
    recipeController.dispose();
    super.dispose();
  }

  void disposeProdict() {
    // Clean up the controller when the widget is disposed.
    productController.dispose();
    super.dispose();
  }

  void disposeGram() {
    // Clean up the controller when the widget is disposed.
    quantityController.dispose();
    super.dispose();
  }

  void clearProduct() {
    productController.clear();
    quantityController.clear();
  }

  void clearRecipe() {
    recipeController.clear();
    productController.clear();
    quantityController.clear();
    product = [];
    quantity = [];
  }

  void createRecipe() async {
    print("\n#########\n");
    var ingredients = <Ingredient>[];
    var recipe = Recipe(null, "recipe_name", "description", 215900,
        Timestamp.now(), Timestamp.now(), ingredients);
    var recipeId = await recipesService.addRecipe(recipe);
    recipe = await recipesService.getRecipeById(recipeId);

    recipe.name = recipesName.last;
    recipe.description = description.last;
    recipe.preparationTime = preparationTime.last;
    for (int i = 0; i < product.length; i++) {
      var ingredient = Ingredient("", "name", 0, "quantityMeasure");
      ingredient.name = product[i];
      ingredient.quantity = quantity[i];
      ingredient.quantityMeasure = "gram";
      ingredients.add(ingredient);
    }
    recipe.ingredients = ingredients;
    recipes.add(recipe);
    recipesService.updateRecipe(recipe);

    clearRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
       // const SizedBox(height: 30),
        Positioned(
          top: 110,
          left: 10,
          width: 250,
          child: Container(
            child: TextField(
              controller: recipeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the recipe name',
              ),
            ),
          ),
        ),
        Positioned(
          top: 120,
          right: 35,
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                recipesName.add(recipeController.text);
                description.add(descriptionController.text);
                int prep = int.parse(preparationTimeController.text);
                preparationTime.add(prep);
                createRecipe();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RecipesPage()));
              },
              child: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(50, 50),
                shape: const CircleBorder(),
              ),
            ),
          ),
        ),
        Positioned(
          top: 220,
          left: 10,
          width: 250,
          child: Container(
            // Enter product name
            child: TextField(
              controller: productController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the product name',
              ),
            ),
          ),
        ),
        Positioned(
          top: 360,
          left: 10,
          width: 250,
          child: Container(
            // Enter product name
            child: TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the description',
              ),
            ),
          ),
        ),
        Positioned(
          top: 450,
          left: 10,
          width: 250,
          child: Container(
            // Enter product name
            child: TextField(
              controller: preparationTimeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the preparation time',
              ),
            ),
          ),
        ),

        // Text to add gram of product
        Positioned(
          top: 220,
          right: 10,
          width: 100,
          child: Container(
            child: TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'g product'),
            ),
          ),
        ),
        // button to add another product
        Positioned(
            top: 300,
            left: 150,
            child: Container(
                child: ElevatedButton(
                    onPressed: () {
                      product.add(productController.text);
                      int s = int.parse(quantityController.text);
                      quantity.add(s);
                      clearProduct();
                    },
                    child: Text('Add Product')))),
      ],
    );
  }
}
