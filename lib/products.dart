import 'package:flutter/material.dart';

class MyProductsPage extends StatefulWidget{
  const MyProductsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState(){return _MyProductsPageState();}
}

class _MyProductsPageState extends State<MyProductsPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.green,
      child: Text(
          widget.title,
          style: const TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white
          ),
        ),
    );
  }
}