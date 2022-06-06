import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'MyIcons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.lightGreen,),
      home: const MyHomePage(title: 'Frigider virtual'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  PageController pageController = PageController();

  void onTap(int index){
    setState((){ currentIndex = index; });
    pageController.animateToPage(index, duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

  final screens = [
        // FridgePage(),
        // RecipesPage(),
        // MarketPage(),
        // ProfilePage(),
    Container(color: Colors.white),
    Container(color: Colors.grey),
    Container(color: Colors.blueGrey),
    Container(color: Colors.white10)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text(widget.title),),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MyIcons.fridge),
              label: 'Fridge',
              backgroundColor: Colors.lightGreen,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: 'Recipes',
              backgroundColor: Colors.lightGreen,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: 'Market',
              backgroundColor: Colors.lightGreen,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.lightGreen,
            )
        ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      iconSize: 30,
      selectedFontSize: 20,
      showUnselectedLabels: true,
      unselectedFontSize: 15,
      onTap: onTap),
    );
  }
}


class DatabaseService{

  // collection reference
  final CollectionReference recepie = FirebaseFirestore.instance.collection('recipes');

}
