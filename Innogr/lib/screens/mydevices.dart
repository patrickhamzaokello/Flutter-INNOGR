import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Innogr/core/sensor_values.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyDevices extends StatefulWidget {
  const MyDevices({Key key}) : super(key: key);

  @override
  _MyDevicesState createState() => _MyDevicesState();
}

class _MyDevicesState extends State<MyDevices> {
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
 






 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyDevices'),
        ),
        body: WillPopScope(
          onWillPop: null,
          child: Container(
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
          ),
        ));
  }
}

// create a details page for our newsfeed
class DetailPage extends StatelessWidget {
  // create a final object of type user
  final User user;
  // Create a constructor to initialize the page
  DetailPage(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Container(),
    );
  }
}
