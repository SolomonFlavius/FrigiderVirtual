// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frigider_virtual/screens/register.dart';
import 'package:frigider_virtual/widgets/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frigider_virtual/services/users_service.dart';
import 'package:frigider_virtual/settings/notification_management.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  //variabile
  String email = '';
  String password = '';
  bool isRememberMe = false;
  bool emailValid = false;
  bool passwordValid = false;

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
          height: 60,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
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
          height: 60,
          child: TextField(
            obscureText: true,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
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

  Widget buildForgotPasswordButton() {
    return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          onPressed: () => print("Forgot Password pressed"),
          padding: EdgeInsets.only(right: 0),
          child: Text('Forgot Password?',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ));
  }

  Widget BuildRemember() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          Text('Remember me',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget buildLogin() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          if (emailValid && passwordValid) {
            SignIn();
          } else {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Invalid text'),
                      content: Text('Email or password is invalid'),
                    ));
          }
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildSignUp() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Register()),
        );
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: 'Don\'t have an Account?',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        TextSpan(
            text: 'Sign up',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
      ])),
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
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 60),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30),
                          buildEmail(),
                          SizedBox(height: 20),
                          buildPassword(),
                          //buildForgotPasswordButton(),
                          //BuildRemember(),
                          buildLogin(),
                          buildSignUp(),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    ));
  }

  Future SignIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // update the fcm token for the current user
      var fcmToken = await NotificationManagement().getFCMToken();
      await UsersService.updateUserFcmToken(email, fcmToken);

      /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyNavBar(
                  title: '',
                )),
      );*/
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Invalid account'),
                content: Text('Email or password are wrong'),
              ));
    }
  }
}
