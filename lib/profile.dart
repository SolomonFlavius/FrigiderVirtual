import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:frigider_virtual/auth.dart';
import 'package:frigider_virtual/services/users_service.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
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
        child: Text('Logout from ' + user.email!),
      ),
    );
  }
}
