import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'main.dart';
import 'package:frigider_virtual/AddRecipeForm.dart';

class ShowRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Virtual Fridge';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
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
          child: Text("Mamaliga\n Oua 10g\n Faina 20g"),
        ),
      ),
    ]);
  }
}
