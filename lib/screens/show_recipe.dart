import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';

import '../main.dart';
import 'package:frigider_virtual/screens/add_recipe_form.dart';

import '../../models/recipe.dart';
import '../../services/recipe_service.dart';
import 'ingredients_show.dart';

int iterator = 0;

class ShowRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _ShowRecipes(),
      ),
    );
  }
}

class _ShowRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Positioned(
        top: 10,
        left: 110,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: const Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Recepies List',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
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
      Positioned(
        top: 500,
        right: 300,
        child: Container(
          child: ElevatedButton(
            child: const Icon(Icons.soup_kitchen_outlined),
            onPressed: () {},
          ),
        ),
      ),
      Positioned(
        top: 250,
        right: 150,
        child: Container(
          color: Colors.grey,
        ),
      ),
      Positioned(
        top: 80,
        left: 160,
        child: Container(
          color: Colors.blue,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (int i = 0; i < recipe.length; i++)
              Container(
                child: InkWell(
                  onTap: () {
                    print(i);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => IngredientsShow(i)));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(recipe[i].getName.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ),
          ]),
        ),
      ),
    ]);
  }
}
