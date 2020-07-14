import 'dart:convert';

import 'package:Innogr/homescreen.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'forgotpassword.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

/* Below is our main method where code execution will begin*/
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create a FutureBuilder for our login
  Future loginUser(String email, String password) async {
    String url = "http://192.168.0.6/login.php";
    final response = await http.post(url,
        headers: {"Accept": "Application/json"},
        body: {'email': email, 'password': password});
    var convertedDatatoJson = jsonDecode(response.body);
    return convertedDatatoJson;
  }

  // create a form key for our form
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    String message = "";

    final txtEmail = TextFormField(
      controller: emailController,
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Please enter your email';
        } else {
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
    final txtPassword = TextFormField(
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your password';
        } else {
          print("Password is valid");
        }
      },
      //Add some styling to the password input field

      decoration: InputDecoration(
          icon: new Icon(Icons.security),
          border: InputBorder.none,
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.grey[400])),
    );
    final btnLogin = FlatButton(
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          print("Your data is submitted!");
          var email = emailController.text;
          var password = passwordController.text;
          setState(() {
            message = "Please wait...";
          });
          var rsp = await loginUser(email, password);
          print(rsp);
          if (rsp.containsKey('status')) {
            setState(() {
              message = rsp['status_text'];
            });

            if (rsp['status'] == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }
          } else {
            setState(() {
              message = "Login Failed";
            });
          }
        }
      },
      child: Center(
        child: Text(
          "Login",
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
                                      color: Color.fromRGBO(143, 148, 251, .2),
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
                                  // Using a textform field to validate user input
                                  child: txtPassword,
                                )
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
                            child: btnLogin,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(message),
                      /*
                      
                      CODE BELOW IS FOR THE TEXTS TO ROUTE TO SIGNUP AND FORGOT PASSWORD PAGES
                      
                      */
                      SizedBox(
                        height: 50.0,
                      ),
                      FadeAnimation(
                        1.5,
                        Container(
                          // This container holds navigator to the ForgotPassword route
                          child: new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()),
                              );
                            },
                            child: new Text("Forgot Password?",
                                style: TextStyle(
                                    color: Colors.green) // Changes text color
                                ),
                          ),
                        ),
                      ),
                      /* SizedBox is for spacing a widget either using width or height properties */
                      SizedBox(
                        height: 30,
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
                                    builder: (context) => SignUp()),
                              );
                            },
                            child: new Text("Create New Account",
                                style: TextStyle(
                                    color:
                                        Colors.green) // Changes color to green
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
