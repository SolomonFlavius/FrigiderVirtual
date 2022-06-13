// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:frigider_virtual/auth.dart';
import 'package:frigider_virtual/models/user.dart' as UserDB;
import 'package:frigider_virtual/services/users_service.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

Future<String> getFirstName()
async
 {
  var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return 'null';
      }
      var userEmail = currentUser.email;
      if (userEmail == null) {
        return 'null';
      }
      var userData =  await UsersService.getUserByEmail(userEmail);
      return userData!.firstName;
}


class _Profile extends State<Profile> {
  static final user = FirebaseAuth.instance.currentUser!;
  final firstName = getFirstName();


  Widget buildLogout() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
            // remove the fcm token for the current user before signing out
            var currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser == null) {
              return;
            }
            var userEmail = currentUser.email;
            if (userEmail == null) {
              return;
            }
            await UsersService.updateUserFcmToken(userEmail, null);
            await FirebaseAuth.instance.signOut();
          },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'LOGOUT FROM ${user.email}',
          style: TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildFirstName()
  {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: Text(
        'First name: $firstName'
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0x665ac18e),
                      Color(0x995ac18e),
                      Color(0xcc5ac18e),
                      Color(0xff5ac18e),
                    ])),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Profile',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30),
                          buildLogout(),
                          buildFirstName(),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    ));
  }
}
