import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';

import '../main.dart';
import 'package:frigider_virtual/screens/add_recipe_form.dart';
import '../services/recipes_service.dart';
import '../screens/show_recipe.dart';

import '../../models/recipe.dart';
import 'show_recipe.dart';

class Ingredients extends StatelessWidget {
  int i;

  Ingredients(this.i) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                child: ShowIngredients(i))));
  }
}

class ShowIngredients extends StatelessWidget {
  int i;

  ShowIngredients(this.i) {}

  void DeleteRecipe() async {
    await recipesService.deleteRecipe(recipes[i].id.toString());
    for (int j = i; j < recipes.length - 1; j++) recipes[j] = recipes[j + 1];
    recipes.length--;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Align(
          alignment: Alignment.topCenter,
          child: Text(recipes[i].name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(153, 0, 0, 0)))),
      Container(
          alignment: Alignment.center,
          child: SizedBox(
              width: 300,
              height: 400,
              child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(children: [
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                              top: 5,
                            ),
                            child: Text("Description:",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold))),
                        Padding(
                            padding: EdgeInsets.only(top: 5, left: 5),
                            child: Text(recipes[i].description,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0)))),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                              top: 5,
                            ),
                            child: Text("Preparation time:",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold))),
                        Padding(
                            padding: EdgeInsets.only(top: 5, left: 5),
                            child: Text(recipes[i].preparationTime.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0)))),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                              left: 110,
                              top: 10,
                            ),
                            child: Text("Ingredients",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                    for (int j = 0; j < recipes[i].ingredients.length; j++)
                      Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            top: 5,
                          ),
                          child: Text(
                              recipes[i].ingredients[j].name +
                                  ", " +
                                  recipes[i]
                                      .ingredients[j]
                                      .quantity
                                      .toString() +
                                  " " +
                                  recipes[i].ingredients[j].quantityMeasure,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0)))),
                  ])))),
      Positioned(
        top: 500,
        left: 300,
        child: Container(
          child: ElevatedButton(
            child: const Icon(Icons.delete),
            onPressed: () {
              DeleteRecipe();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => RecipesPage()));
            },
          ),
        ),
      ),
    ]);
  }
}
