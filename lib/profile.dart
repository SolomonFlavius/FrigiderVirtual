import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:frigider_virtual/auth.dart';


class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile>
{

  final user = FirebaseAuth.instance.currentUser!;

   @override
  Widget build(BuildContext context) {

    return Scaffold(body: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () {
          FirebaseAuth.instance.signOut();

        },
        child: Text('Logout from ' + user.email!),
      ),);
  }

}
