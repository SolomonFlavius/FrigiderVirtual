import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';

import '../main.dart';
import 'package:frigider_virtual/screens/add_recipe_form.dart';

import '../../models/recipe.dart';

import 'ingredients_show.dart';
import '../services/recipes_service.dart';

final RecipesService recipesService = RecipesService();
late List<Recipe> recipes = [];

class RecipesPage extends StatefulWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ShowRecipes();
}

class ShowRecipes extends State<RecipesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getRecipes();
    });
  }

  _getRecipes() async {
    recipes = await recipesService.getRecipesWithIngredients();
    setState(() => recipes);
  }

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
                    child: _ShowRecipes()))));
  }
}

class _ShowRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        alignment: Alignment.center,
        child: ListView(children: <Widget>[
          for (int i = 0; i < recipes.length; i++)
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200,
                height: 70,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Ingredients(i)));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(recipes[i].name,
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 0, 0))),
                    ),
                  ),
                ),
              ),
            ),
        ]),
      ),
      Positioned(
        top: 500,
        left: 300,
        child: Container(
          child: ElevatedButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddRecipe()));
            },
          ),
        ),
      ),
    ]);
  }
}
