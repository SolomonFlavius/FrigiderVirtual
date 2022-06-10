import 'package:firebase_core/firebase_core.dart';
import 'package:frigider_virtual/settings/notification_management.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frigider_virtual/navbar.dart';
import 'package:frigider_virtual/products.dart';
import 'package:frigider_virtual/auth.dart';
import 'package:frigider_virtual/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (value) => {
      runApp(const MyApp()),
      NotificationManagement().configure(),
    },
  );
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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData)
          {
            return MyNavBar(title: '');
          }
          else
          {
            return Auth();
          }
        },
      )
    );
  }
}
