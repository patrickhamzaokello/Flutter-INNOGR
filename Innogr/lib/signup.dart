import 'Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'homescreen.dart';
import 'dart:io';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // create a form key for our signup page
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final phoneController = TextEditingController();
    final txtEmail = TextFormField(
      controller: emailController,
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Please enter your email';
        } else {
          // Using a regular expression to validate the email
          Pattern pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return 'Enter a valid email';
          } else
            print("Email is valid");
        }
      },
      //Add some styling to the email input box

      decoration: InputDecoration(
          icon: new Icon(Icons.email),
          border: InputBorder.none,
          hintText: "Email",
          hintStyle: TextStyle(color: Colors.grey[400])),
    );
    final txtPhoneNumber = TextFormField(
      controller: phoneController,
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Please enter your phone number';
        } else {
          // Using a regular expression to validate the ephone number
          Pattern pattern = r'^\d{10}$'; // allow only 10 digit numbers
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return 'Enter a valid phone number';
          } else
            print("Phone number is valid");
        }
      },
      //Add some styling to the email input box

      decoration: InputDecoration(
          icon: new Icon(Icons.phone_iphone),
          border: InputBorder.none,
          hintText: "Phone Number",
          hintStyle: TextStyle(color: Colors.grey[400])),
    );
    final txtPassword = TextFormField(
      controller: passwordController,
      obscureText: true,
      validator: (pass1) {
        if (pass1.isEmpty) {
          return 'Please enter your password';
        } else {
          print("Password 1 is valid");
        }
      },
      //Add some styling to the password input field

      decoration: InputDecoration(
          icon: new Icon(Icons.security),
          border: InputBorder.none,
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.grey[400])),
    );
    final txtRepeatPassword = TextFormField(
      controller: confirmPasswordController,
      obscureText: true,
      validator: (pass2) {
        if (pass2.isEmpty) {
          return 'Please confirm your password';
        } else if (passwordController.text != pass2) {
          // compare first and second passwords
          return "Passwords don't match!";
        } else {
          print("Success! Passwords match");
        }
      },
      //Add some styling to the password input field

      decoration: InputDecoration(
          icon: new Icon(Icons.security),
          border: InputBorder.none,
          hintText: "Confirm Password",
          hintStyle: TextStyle(color: Colors.grey[400])),
    );
    final btnSignUp = FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          print("Your data is submitted!");
        }
      },
      child: Center(
        child: Text(
          "SignUp",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    // This container places the company image on the appbar
                    height: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.8,
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[100]))),
                                    child: txtEmail,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[100]))),
                                    child: txtPhoneNumber,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[100]))),
                                    child: txtPassword,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[100]))),
                                    child: txtRepeatPassword,
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          2,
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(0, 179, 0, 1),
                                  Color.fromRGBO(0, 179, 0, 1),
                                ])),
                            child: Container(
                              // THis container holds navigator to the HomeScreen
                              child: btnSignUp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        FadeAnimation(
                          1.5,
                          Container(
                            // This container holds navigator to the SignUp route
                            child: new GestureDetector(
                              onTap: () {
                                // Navigator.push() method takes us to the SignUp page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              child: new Text("Login",
                                  style: TextStyle(
                                      color: Colors
                                          .green) // Changes color to green
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
