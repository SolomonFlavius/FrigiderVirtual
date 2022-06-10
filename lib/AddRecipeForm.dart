import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'dart:collection';

import 'main.dart';
import 'ShowRecipe.dart';

List<String> recepies = [];
HashMap<String, List<List<String>>> products = HashMap();

class AddRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Virtual Fridge';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
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
  final gramController = TextEditingController();

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
    gramController.dispose();
    super.dispose();
  }

  void clearProduct() {
    productController.clear();
    gramController.clear();
  }

  void clearRecepie() {
    recipeController.clear();
    productController.clear();
    gramController.clear();
    for (var i = 0; i < recepies.length; i++) {
      print(recepies[i]);
    }
  }

  void printProduct() {
    print("Product: " + productController.text);
    print("Quantity: " + gramController.text);
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
                recepies.add(recipeController.text);
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
              controller: gramController,
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
                      clearProduct();
                    },
                    child: Text('Add Product')))),
      ],
    );
  }
}
