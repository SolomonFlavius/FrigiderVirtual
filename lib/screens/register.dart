import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frigider_virtual/widgets/navbar.dart';
import 'package:frigider_virtual/models/user.dart' as UserDB;
import 'package:frigider_virtual/services/users_service.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register>
{
  //variabile
  String firstName = '';
  String lastName = '';
  String password = '';
  String email = '';
  String phone = '';
  bool emailValid = false;
  bool passwordValid = false;
  bool phoneValid = false;

  late UserDB.User user;

    Widget buildFirstName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'First Name',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 40,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.email, color: Color(0xffac18e)),
                hintText: 'First Name',
                hintStyle: TextStyle(color: Colors.black38)),
            onChanged: (value) => setState(() {
              firstName = value;
            }),
          ),
        )
      ],
    );
  }

    Widget buildLastName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Last Name',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 40,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                
                prefixIcon: Icon(Icons.email, color: Color(0xffac18e)),
                hintText: 'Last Name',
                hintStyle: TextStyle(color: Colors.black38)),
            onChanged: (value) => setState(() {
              lastName = value;
            }),
          ),
        )
      ],
    );
  }

    Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 40,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                
                prefixIcon: Icon(Icons.email, color: Color(0xffac18e)),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black38)),
            onChanged: (value) => setState(() {
              email = value;
              emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(email);
            }),
          ),
        )
      ],
    );
  }

    Widget buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone number',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 40,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                
                prefixIcon: Icon(Icons.email, color: Color(0xffac18e)),
                hintText: 'Phone number',
                hintStyle: TextStyle(color: Colors.black38)),
            onChanged: (value) => setState(() {
              phone = value;
              phoneValid = RegExp(
                     r'(^(?:[+0]4)?[0-9]{10,12}$)')
                  .hasMatch(phone);
            }),
          ),
        )
      ],
    );
  }

    Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 40,
          child: TextField(
            obscureText: true,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                
                prefixIcon: Icon(Icons.lock, color: Color(0xffac18e)),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black38)),
            onChanged: (value) => setState(() {
              password = value;
              passwordValid = password.length >= 8;
            }),
          ),
        )
      ],
    );
  }

    Widget buildRegister() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          if (emailValid && passwordValid && phoneValid) {
            
            SingUp();
            user = UserDB.User(
              null,
              firstName,
              lastName,
              email,
              phone,
              createdAt: Timestamp.now(),
              updatedAt: Timestamp.now(),
            );
            await UsersService.addUser(user);
            
          } else {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Cannot create account'),
                      content: Text(
                          'Email or password or phone number are not valid'),
                    ));
          }
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'REGISTER',
          style: TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
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
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      buildFirstName(),
                      SizedBox(height: 20),
                      buildLastName(),
                      SizedBox(height: 20),
                      buildEmail(),
                      SizedBox(height: 20),
                      buildPhoneNumber(),
                      SizedBox(height: 20),
                      buildPassword(),
                      SizedBox(height: 20),
                      buildRegister(),
                    ],
                  ),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
  
  Future SingUp() async{
  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyNavBar(
                  title: '',
                )),
      );
  }on FirebaseAuthException catch (e)
  {
    showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Cannot create account'),
                content: Text('You cannot create account with this credentials'),
              ));
  }
}

}


