import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';

// Create a Form widget.
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

// Create a corresponding State class.
// This class holds data related to the form.
class _ForgotPasswordState extends State<ForgotPassword> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password?"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: txtEmail,
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 30.0,
              ),
              FadeAnimation(
                2,
                Container(
                  height: 50.0,
                  width: 500.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(0, 179, 0, 1),
                        Color.fromRGBO(0, 179, 0, 1),
                      ])),
                  child: RaisedButton(
                    color: Colors.greenAccent,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
