import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Virtual Fridge'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => ShowRecepies();
}

class ShowRecepies extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Virtual Fridge';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: _ShowRecepies(),
      ),
    );
  }
}

// First Page
class _ShowRecepies extends StatelessWidget {
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
        top: 650,
        left: 300,
        child: Container(
          child: ElevatedButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => _AddRecepie()));
            },
          ),
        ),
      ),
      Positioned(
        top: 650,
        right: 300,
        child: Container(
          child: ElevatedButton(
            child: const Icon(Icons.soup_kitchen_outlined),
            onPressed: () {},
          ),
        ),
      ),
    ]);
  }
}

// Secound Page
class _AddRecepie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Virtual Fridge';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const AddRecepieForm(),
      ),
    );
  }
}

class AddRecepieForm extends StatefulWidget {
  const AddRecepieForm({super.key});

  @override
  _AddRecepieForm1 createState() => _AddRecepieForm1();
}

class _AddRecepieForm1 extends State<AddRecepieForm> {
  final recepieName = List<String>;
  final productName = List<String>;
  int gram = 0;

  final recepieController = TextEditingController();
  final productController = TextEditingController();
  final gramController = TextEditingController();

  void disposeRecepie() {
    // Clean up the controller when the widget is disposed.
    recepieController.dispose();
    super.dispose();
  }

  void disposeProdict() {
    // Clean up the controller when the widget is disposed.
    productController.dispose();
    super.dispose();
  }

  void disposeGram() {
    // Clean up the controller when the widget is disposed.
    gramController.dispose();
    super.dispose();
  }

  void clearProduct() {
    productController.clear();
    gramController.clear();
  }

  void clearRecepie() {
    recepieController.clear();
    productController.clear();
    gramController.clear();
  }

  void printProduct() {
    print("Product: " + productController.text);
    print("Quantity: " + gramController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 20,
          left: 10,
          width: 250,
          child: Container(
            child: TextField(
              controller: recepieController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the recepie name',
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 35,
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                clearRecepie();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              },
              child: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(50, 50),
                shape: const CircleBorder(),
              ),
            ),
          ),
        ),
        Positioned(
          top: 120,
          left: 10,
          width: 250,
          child: Container(
            // Enter product name
            child: TextField(
              controller: productController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter the product name',
              ),
            ),
          ),
        ),
        // Text to add gram of product
        Positioned(
          top: 120,
          right: 10,
          width: 100,
          child: Container(
            child: TextField(
              controller: gramController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'g product'),
            ),
          ),
        ),
        // button to add another product
        Positioned(
            top: 200,
            left: 150,
            child: Container(
                child: ElevatedButton(
                    onPressed: () {
                      printProduct();
                      clearProduct();
                    },
                    child: Text('Add Product')))),
      ],
    );
  }
}
