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
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0x665ac18e),
              Color(0x995ac18e),
              Color(0xcc5ac18e),
              Color(0xff5ac18e),
            ])),
        child: ListView(
          children: [
            Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 40,
                    decoration: TextDecoration.none,
                    color: Colors.white),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black, size: 40),
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
                  SizedBox(
                      width: 40,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            onPrimary: Colors.green,
                            padding: const EdgeInsets.only(right: 5),
                          ),
                          child: const Icon(CupertinoIcons.pencil,
                              size: 40, color: Colors.black))),
                  SizedBox(
                      width: 40,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            onPrimary: Colors.green,
                            padding: const EdgeInsets.only(right: 20),
                          ),
                          child: const Icon(Icons.list_alt,
                              size: 40, color: Colors.black))),
                ],
              ),
            )));
  }
}
