import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';

import '../main.dart';
import 'package:frigider_virtual/screens/add_recipe_form.dart';

import '../../models/recipe.dart';
import '../../services/recipe_service.dart';

class IngredientsShow extends StatelessWidget {
  int i;

  IngredientsShow(this.i) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int j = 0; j < recipe[i].getIngredients.length; j++)
              Container(
                  child: Text(recipe[i].getIngredients[j].getName.toString()))
          ],
        ),
      ),
    );
  }
}
