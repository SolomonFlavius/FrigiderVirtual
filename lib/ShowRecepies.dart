import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:frigider_virtual/AddRecepieForm.dart';

class ShowRecepies extends StatelessWidget {
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
                  .push(MaterialPageRoute(builder: (context) => AddRecepie()));
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