import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frigider_virtual/products.dart';
import 'package:frigider_virtual/auth.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Auth(),//Se schimba Auth cu MyProductsPage pentru a intra pe pagina de lista produse
    );
  }
}

class DatabaseService {
  // collection reference
  final CollectionReference recipes =
      FirebaseFirestore.instance.collection('recipes');
}
