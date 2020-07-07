import 'package:Innogr/homescreen.dart';

import 'Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'forgotpassword.dart';

/* Below is our main method where code execution will begin*/
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                                  child: TextFormField(
                                    //Add some styling to the email input box
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email or Phone number",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  // Using a textform field to validate user input
                                  child: TextFormField(
                                    //Add some styling to the password input field
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
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
                            child: new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              },
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*
                      
                      CODE BELOW IS FOR THE TEXTS TO ROUTE TO SIGNUP AND FORGOT PASSWORD PAGES
                      
                      
                      
                      */
                      SizedBox(
                        height: 50,
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
        ));
  }
}
