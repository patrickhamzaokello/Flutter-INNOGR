import 'package:Innogr/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:Innogr/login.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // check is a user had logged in
    _mockCheckForSession().then((status) {
      if (status) {
        _navigateToHome(); // open homescreen if user was logged in
      } else {
        _navigateToLogin(); // open loginscreen if user had not logged in
      }
    });
  }

  // Create a future builder to determine if the user is logged in or not
  //if logged in, page opens homescreen
  //else page opens login screen
  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    return false;
  }

  void _navigateToHome() {
    // pushReplacement method prevents user from heading
    // back to the splash screen after pressing back button
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  void _navigateToLogin() {
    // pushReplacement method prevents user from heading
    // back to the splash screen after pressing back button
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: 0.8,
              child: Image.asset('assets/images/background.png'),
            )
          ],
        ),
      ),
    );
  }
}
