import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:frigider_virtual/ShowRecepies.dart';
import 'package:frigider_virtual/AddRecepieForm.dart';
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
      home: Auth(),//Se schimba Auth cu MyProductsPage sau altcv pentru a testa pagina
    );
  }
}

}
