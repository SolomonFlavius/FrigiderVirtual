import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frigider_virtual/services/users_service.dart';
import 'models/ingredient.dart';
import 'package:frigider_virtual/services/market_recipe_service.dart';

import 'models/market_recipe.dart';

class MarketPage extends StatefulWidget{
  const MarketPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MarketRecipe?>(
        future: readMarketRecipe(),
        builder: (context, snapshot){
          if (snapshot.hasError){
            return Text("snapshot error");
          }
          else if (snapshot.hasData){
            final marketRecipe = snapshot.data;
            return marketRecipe == null
                ? Center(child: Text('no recipe'))
                : buildMarketRecipe(marketRecipe);
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
      );
  }

  Widget buildMarketRecipe(MarketRecipe marketRecipe){
    return ListTile(
      leading: CircleAvatar(child: Text('${marketRecipe.description}')),
      title: Text(marketRecipe.name),
      subtitle: Text(marketRecipe.preparationTime),
    );
  }

  Stream<List<MarketRecipe>> readMarketRecipes() => FirebaseFirestore.instance
      .collection('market_recipes')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => MarketRecipe.fromMap(doc.data())).toList());

  Future<MarketRecipe?> readMarketRecipe() async{
      final docMarketRecipes = FirebaseFirestore.instance
          .collection('market_recipe')
          .doc('p20W3LU61kV0L6kxNjZm');
      final snapshot = await docMarketRecipes.get();

      if (snapshot.exists){
        return MarketRecipe.fromMap(snapshot.data()!);
      }
  }

}