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
  State<MyHomePage> createState() => _ShowRecepies();
}

// First Page
class _ShowRecepies extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => _AddRecepie()));
        },
        child: const Icon(Icons.add),
      ),
    );
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
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              // Enter recepie name
              Expanded(
                flex: 3,
                child: TextField(
                  controller: recepieController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the recepie name',
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 50,
              ),
              // Button to add the recepie
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    clearRecepie();
                  },
                  child: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(50, 50),
                    shape: const CircleBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              // Enter product name
              Expanded(
                flex: 3,
                child: TextField(
                  controller: productController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the product name',
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 50,
              ),
              // Text to add gram of product
              Expanded(
                child: TextField(
                  controller: gramController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'g product'),
                ),
              ),
            ],
          ),
        ),
        // button to add another product
        Container(
            child: ElevatedButton(
                onPressed: () {
                  printProduct();
                  clearProduct();
                },
                child: Text('Add Product'))),
      ],
    );
  }
}
