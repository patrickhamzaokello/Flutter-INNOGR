import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:Innogr/core/assets.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Innogr/core/sensor_values.dart';
import 'package:Innogr/core/network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

/// This is the stateless widget that the main application instantiates.
class _ProfileState extends State<Profile> {
  // Json code here

  Future<List<User>> _getUsers() async {
    // async converts our function into an asynchronous function

    //get data as an http request
    var data = await http.get('https://jsonplaceholder.typicode.com/users');
    // now convert the data to a JSON object
    var jsonData = json.decode(data.body);
    //now create a list
    List<User> users = [];
    // use a for loop to loop over JSON data object
    for (var u in jsonData) {
      // populate the users list in here
      // create a user onbject for each item inside the array
      User user =
          User(u["id"], u['phone'], u['email'], u['name'], u["website"]);

      // now insert user object into the user's array
      users.add(user);
    }
    // now print the length of the user's list
    print(users.length);
    // now we return the user's list
    return users;
  }

  /*
  
  Futre builder above
  
  
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green.shade300, Colors.green.shade500]),
            ),
          ),
          ListView.builder(
            itemCount: 7,
            itemBuilder: _mainListBuilder,
          ),
        ],
      ),
    );
  }

  // CODE FOR WIDGETS ARE LISTED BEWOW
  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return _buildHeader(context);
    if (index == 3)
      return Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
          child:
              Text("Recent Posts", style: Theme.of(context).textTheme.title));
    return _recentPosts(context);
  }

  // Lets create a container for our future builder
  Container _recentPosts(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // first we check if snapshot.data is null or not
          if (snapshot.data == null) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Call the loader from the loader.dart file
                  SpinKitThreeBounce(
                    color: Colors.greenAccent,
                  ),
                ],
              ),
            );
          } else {
            // snapshot will hold all data from the _getUsers() function
            return ListView.builder(
              padding: EdgeInsets.all(6),
              itemCount: snapshot.data.length,
              // item builder is where we defune how each item in our list looks like

              itemBuilder: (BuildContext context, int index) {
                // use the index to access any value inside  our array
                return Card(
                  elevation: 3,
                  child: Row(
                    //This row is a child of the card
                    children: <Widget>[
                      //The widget children are a child of row widget
                      Container(
                        // Container widget here is a child of children widget
                        height: 125,
                        width: 110,
                        padding: EdgeInsets.only(
                            left: 0, top: 10, bottom: 70, right: 20),
                        decoration: BoxDecoration(
                          // Box decoration is a child of container
                          image: DecorationImage(
                              // Decoration image is a child of BoxDecoration
                              image: CachedNetworkImageProvider(
                                  snapshot.data[index].name),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        // Padding widget is a child of row widget

                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          // This column is a child of padding widget
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // These are the children of the column widget
                            //First text widget
                            Text(
                              // First child of the column widget
                              snapshot.data[index].name,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17),
                            ),
                            //Second text widget
                            Text(
                              // Second child of the column widget
                              snapshot.data[index].phone,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            //Third text widget
                            Text(
                              // Third child of the column widget
                              snapshot.data[index].email,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "Hafise Alyanga",
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Farmer"),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "12",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Posts".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "2000",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Followers".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "120",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Following".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(avatars[0]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
