import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frigider_virtual/services/users_service.dart';
import 'models/ingredient.dart';
import 'package:frigider_virtual/models/market_recipe.dart' as MarketRecipeDB;

class MarketPage extends StatefulWidget{
  const MarketPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>{

  String name = '';
  String preparationTime = '';
  double overallRating = 0;
  int totalRatings = 0;
  String description = '';
  late List<Ingredient> ingredients;

  late MarketRecipeDB.MarketRecipe marketRecipe;

  @override
  Widget build(BuildContext context) {

  }


}