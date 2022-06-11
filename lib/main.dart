import 'package:firebase_core/firebase_core.dart';
import 'package:frigider_virtual/settings/notification_management.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:frigider_virtual/auth.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
      home:
          Auth(), //Se schimba Auth cu MyProductsPage sau altcv pentru a testa pagina
    );
  }
}
