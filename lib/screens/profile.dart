// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:frigider_virtual/screens/auth.dart';
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

Future<String> getLastName() async {
  var currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    return 'null';
  }
  var userEmail = currentUser.email;
  if (userEmail == null) {
    return 'null';
  }
  var userData = await UsersService.getUserByEmail(userEmail);
  return userData!.lastName;
}

Future<String> getPhoneNumber() async {
  var currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    return 'null';
  }
  var userEmail = currentUser.email;
  if (userEmail == null) {
    return 'null';
  }
  var userData = await UsersService.getUserByEmail(userEmail);
  return userData!.phoneNumber;
}

Future<String> getEmail() async {
  var currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    return 'null';
  }
  var userEmail = currentUser.email;
  if (userEmail == null) {
    return 'null';
  }
  var userData = await UsersService.getUserByEmail(userEmail);
  return userData!.email;
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
            Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Auth()),
          );
          },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.red,
        child: Text(
          'LOGOUT',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildFirstName(){
    return FutureBuilder<String>(
      future: getFirstName(),
      builder: (context, snapshot)
      {
        if(snapshot.hasError)
        {
          return Text('snapshot error');
        }
        else if(snapshot.hasData)
        {
          final firstName = snapshot.data;
          return firstName == null
            ? Center(child: Text('no name'))
            : Center(child: Text('First name: ${firstName}',
                            style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)));
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      }
      );
  }

  Widget buildLastName() {
    return FutureBuilder<String>(
        future: getLastName(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('snapshot error');
          } else if (snapshot.hasData) {
            final lastName = snapshot.data;
            return lastName == null
                ? Center(child: Text('no name'))
                : Center(
                    child: Text('Last name: ${lastName}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildPhoneNumber() {
    return FutureBuilder<String>(
        future: getPhoneNumber(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('snapshot error');
          } else if (snapshot.hasData) {
            final phoneNumber = snapshot.data;
            return phoneNumber == null
                ? Center(child: Text('no name'))
                : Center(
                    child: Text('Phone number: ${phoneNumber}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildEmail() {
    return FutureBuilder<String>(
        future: getEmail(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('snapshot error');
          } else if (snapshot.hasData) {
            final email = snapshot.data;
            return email == null
                ? Center(child: Text('no name'))
                : Center(
                    child: Text('Email: ${email}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
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
                          SizedBox(height: 30),
                          buildFirstName(),
                          SizedBox(height: 10),
                          buildLastName(),
                          SizedBox(height: 10),
                          buildPhoneNumber(),
                          SizedBox(height: 10),
                          buildEmail(),
                          buildLogout(),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    ));
  }
}
