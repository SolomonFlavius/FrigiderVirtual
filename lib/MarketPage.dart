import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MarketPage extends StatefulWidget{
  const MarketPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _MarketPageState();
  }
}

class _MarketPageState extends State<MarketPage>{

  final Stream<QuerySnapshot> recipes = FirebaseFirestore.instance.collection('market_recipes').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: market_recipes,
            builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
        ){

      },
      ),
      ),
    );
  }
}