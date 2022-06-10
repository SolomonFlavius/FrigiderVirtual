import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';

import 'main.dart';
import 'ShowRecepies.dart';

<<<<<<< Updated upstream:lib/AddRecepieForm.dart
class AddRecepie extends StatelessWidget {
=======
final Map<String, List<String>> products = {};
final Map<String, List<int>> quantities = {};
int recipeInteger = 0;
List<String> recipes = [];
List<String> product = [];
List<int> quantity = [];

class AddRecipe extends StatelessWidget {
>>>>>>> Stashed changes:lib/AddRecipeForm.dart
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Virtual Fridge';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const AddRecepieForm(),
      ),
    );
  }
}

class AddRecepieForm extends StatefulWidget {
  const AddRecepieForm({super.key});

  @override
  _AddRecepieForm1 createState() => _AddRecepieForm1();
}

class _AddRecepieForm1 extends State<AddRecepieForm> {
  final recepieName = List<String>;
  final productName = List<String>;
  int gram = 0;

  final recepieController = TextEditingController();
  final productController = TextEditingController();
  final quantityController = TextEditingController();

  void disposeRecepie() {
    // Clean up the controller when the widget is disposed.
    recepieController.dispose();
    super.dispose();
  }

  void disposeProdict() {
    // Clean up the controller when the widget is disposed.
    productController.dispose();
    super.dispose();
  }

  void disposeQuantity() {
    // Clean up the controller when the widget is disposed.
    quantityController.dispose();
    super.dispose();
  }

  void clearProduct() {
    productController.clear();
    quantityController.clear();
  }

  void clearRecepie() {
    recepieController.clear();
    productController.clear();
<<<<<<< Updated upstream:lib/AddRecepieForm.dart
    gramController.clear();
=======
    quantityController.clear();
    product = [];
    quantity = [];
>>>>>>> Stashed changes:lib/AddRecipeForm.dart
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
              controller: recepieController,
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
<<<<<<< Updated upstream:lib/AddRecepieForm.dart
=======
                recipes.add(recipeController.text);
                products[recipes[recipeInteger]] = product;
                quantities[recipes[recipeInteger]] = quantity;
                recipeInteger++;
                print(recipeInteger);
                print(products);
>>>>>>> Stashed changes:lib/AddRecipeForm.dart
                clearRecepie();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
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
                      printProduct();
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
