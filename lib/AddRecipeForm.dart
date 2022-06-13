import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'dart:collection';
import 'package:intl/intl.dart';

import 'main.dart';
import 'ShowRecipe.dart';

import '../services/recipe_service.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

final Map<String?, List<String?>> products = {};
final Map<String?, List<int?>> quantities = {};
List<String?> recipes = [];
List<String?> description = [];
List<String?> product = [];
List<int?> preparationTime = [];
List<int?> quantity = [];

List<Recipe> recipe = [];
RecipesService recipeService = RecipesService();

class AddRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const AddRecipeForm(),
      ),
    );
  }
}

class AddRecipeForm extends StatefulWidget {
  const AddRecipeForm({super.key});

  @override
  _AddRecepieForm1 createState() => _AddRecepieForm1();
}

class _AddRecepieForm1 extends State<AddRecipeForm> {
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

  void clearRecepie() {
    recipeController.clear();
    productController.clear();
    quantityController.clear();
    product = [];
    quantity = [];
  }

  void createRecipe() {
    List<Ingredients> ingredients = [];
    for (int i = 0; i < product.length; i++) {
      Ingredients ing = Ingredients("", 0, "");
      ing.setName = product[i];
      ing.setQuantity = quantity[i];
      ing.setQuantityMeasuree = "gram";
      ingredients.add(ing);
    }
    Recipe rep = Recipe(
        recipes.last,
        description.last,
        preparationTime.last,
        Timestamp.fromDate(DateTime.now()),
        Timestamp.fromDate(DateTime.now()),
        ingredients);
    recipe.add(rep);
    recipeService.addRecipe(recipe.last);
    print("Am adaugta reteta");
  }

  void printProduct() {
    print("Product: " + productController.text);
    print("Quantity: " + quantityController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 20,
          left: 10,
          width: 250,
          child: Container(
            child: TextField(
              controller: recipeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the recepie name',
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 35,
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                recipes.add(recipeController.text);
                description.add(descriptionController.text);
                int prep = int.parse(preparationTimeController.text);
                preparationTime.add(prep);
                products[recipes.last] = product;
                quantities[recipes.last] = quantity;
                print(products);
                createRecipe();
                clearRecepie();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowRecipes()));
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
          top: 120,
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
          top: 260,
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
          top: 350,
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
          top: 120,
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
            top: 200,
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
