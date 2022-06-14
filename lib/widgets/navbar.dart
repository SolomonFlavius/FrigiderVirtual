import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frigider_virtual/screens/show_recipe.dart';
import 'package:frigider_virtual/screens/profile.dart';
import 'my_icons.dart';
import '../screens/market_page.dart';
import '../screens/products.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(14, 77, 5, .1),
  100: Color.fromRGBO(14, 77, 5, .2),
  200: Color.fromRGBO(14, 77, 5, .3),
  300: Color.fromRGBO(14, 77, 5, .4),
  400: Color.fromRGBO(14, 77, 5, .5),
  500: Color.fromRGBO(14, 77, 5, .6),
  600: Color.fromRGBO(14, 77, 5, .7),
  700: Color.fromRGBO(14, 77, 5, .8),
  800: Color.fromRGBO(14, 77, 5, .9),
  900: Color.fromRGBO(14, 77, 5, 1),
};

MaterialColor colorCustom = MaterialColor(0xff0e4d05, color);

class MyNavBar extends StatefulWidget {
  const MyNavBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyNavBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyNavBar> {
  final user = FirebaseAuth.instance.currentUser; //instanta pentru user
  int currentIndex = 0;
  PageController pageController = PageController();

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

  final screens = [
    MyProductsPage(),
    RecipesPage(),
    MarketPage(title: ''),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Frigider Virtual'),
      )),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MyIcons.fridge),
              label: 'Products',
              backgroundColor: Color(0xff0e4d05),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: 'Recipes',
              backgroundColor: Color(0xff0e4d05),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Market',
              backgroundColor: Color(0xff0e4d05),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Color(0xff0e4d05),
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

class DatabaseService {
  // collection reference
  final CollectionReference recepie =
      FirebaseFirestore.instance.collection('recipes');
}
