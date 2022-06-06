import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _MyProductsPageState();
  }
}

class _MyProductsPageState extends State<MyProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.greenAccent,
      child: ListView(
        children: [
          Center(
            child: Text(
              widget.title,
              style: const TextStyle(
                  decoration: TextDecoration.none, color: Colors.white),
            ),
          ),
          Center(
            child: Product(
              productName: "Cheese",
            ),
          ),
          Center(
            child: Product(
              productName: "Bread",
            ),
          ),
          Center(
            child: Product(
              productName: "Chocolate",
            ),
          ),
        ],
      ),
    );
  }
}

class Product extends StatefulWidget {
  Product({Key? key, required this.productName}) : super(key: key);

  String productName;

  @override
  State<StatefulWidget> createState() {
    return _ProductState();
  }
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 6),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: Text(widget.productName,
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 34,
                          ))),
                  const Icon(CupertinoIcons.pencil, size: 40),
                  const Icon(Icons.list_alt, size: 40)
                ],
              ),
            )));
  }
}
