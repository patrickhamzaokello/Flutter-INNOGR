import 'dart:async';

import 'package:Innogr/login.dart';
import 'package:Innogr/screens/mydevices.dart';
import 'package:Innogr/screens/newsfeed.dart';
import 'package:Innogr/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'screens/settings.dart';
import 'screens/mydevices.dart';
import 'screens/newsfeed.dart';
import 'screens/profile.dart';
import 'screens/resources.dart';
import 'screens/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Innogr/core/sensor_values.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ));

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Innogr',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the Main widget.
        '/': (context) => Dashboard(),
        '/dashboard': (context) => HomeScreen(),
        '/mydevices': (context) => MyDevices(),
        '/newsfeed': (context) => NewsFeed(),
        '/profile': (context) => Profile(),
        '/resources': (context) => Resources(),
        '/settings': (context) => Settings(),
        '/logout': (context) => SignUp(),
        '/search': (context) => SearchScreen()
      },
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Create a TextEditingController for our search field
  TextEditingController _controller = TextEditingController();

  //Timer for text input
  Timer _debounce;

  Stream _stream;
  // Creating a streamcontroller
  StreamController _streamController;

  String _token = "f0f64a38b39c5dbc34bb6626ccf0114eb7cd7bdd";
  String _url = "https://owlbot.info/api/v4/dictionary/";

  //lets override the initState function
  @override
  void initState() {
    super.initState();
    // initialize our objects in here
    _streamController = StreamController();
    _stream = _streamController.stream; // this is the stream of the controller
    flutterToast = FlutterToast(context);
  }

  // Function to perform search operations
  _search() async {
    // the search request will make a get request to the above given api along with its token

    //then get a response and return to the user
    if (_controller.text == null || _controller.text.length == 0) {
      // check if user has typed anything in the textfield
      _streamController.add(null);
      // add a return keyword to avoid making a get request if the textbox is null
      return;
    }
    // detect if we are in the process of making a guest request
    _streamController.add("waiting");
    // make a get request to the rest api using a get function
    var response = await http.get(_url + _controller.text.trim(),
        headers: {"Authorization": "Token " + _token});

    // Encode the response as a JSON object and then add it to our stream contoller
    _streamController.add(json.decode(response.body));
  }

  // Handle event for  when a back button is pressed

  Future<bool> _onBackPressed(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Exit'),
              content: Text('Proceed to exit?'),
              actions: <Widget>[
                FlatButton(
                    child: Text('No'),
                    onPressed: () => Navigator.pop(context,
                        false)), //this works if you import package dart:io
                FlatButton(
                    child: Text('Yes'), onPressed: () => SystemNavigator.pop())
              ],
            ));
  }

  /*

   */
  DateTime _lastPressedAt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //BELOW IS THE APPBAR
      appBar: AppBar(
        elevation: 0,
        title: Text('INNOGR'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
                // We wrap the TextFormFieldInside an expanded widget to avoid getting errors
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0)),
                  child: TextFormField(
                    // add an event listener

                    onChanged: (String text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 2000), () {
                        _search();
                      });
                    },
                    // create a controller for the TextFormField
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Search",
                      fillColor: Colors.green,
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              // Now we create an icon button as a second child inside this row
              IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {
                    // call a function to perform your search query
                    _search();
                  }),
            ],
          ),
        ),
      ), // here we've called a method to build the appbar

      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 1)) {
            _showToast();
            //Re-timed after two clicks of more than 1 second
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: StreamBuilder(
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              // check if user has typed anything in the textfield
              if (snapshot.data == null) {
                // if no data has been searched for
                return ListView(
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 200.0,
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 3 / 2),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()),
                                  );
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.airport_shuttle,
                                    color: Colors.white,
                                  ),
                                  backgroundColor:
                                      Colors.green.withOpacity(0.9),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 13.0,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyDevices()),
                                  );
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.airport_shuttle,
                                    color: Colors.white,
                                  ),
                                  backgroundColor:
                                      Colors.green.withOpacity(0.9),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "MyDevices",
                                style: TextStyle(
                                  fontSize: 13.0,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsFeed()),
                                  );
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.airport_shuttle,
                                    color: Colors.white,
                                  ),
                                  backgroundColor:
                                      Colors.green.withOpacity(0.9),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Newsfeed",
                                style: TextStyle(
                                  fontSize: 13.0,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Resources()),
                                  );
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.airport_shuttle,
                                    color: Colors.white,
                                  ),
                                  backgroundColor:
                                      Colors.green.withOpacity(0.9),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Support Center",
                                style: TextStyle(
                                  fontSize: 13.0,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Settings()),
                                  );
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.airport_shuttle,
                                    color: Colors.white,
                                  ),
                                  backgroundColor:
                                      Colors.green.withOpacity(0.9),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Settings",
                                style: TextStyle(
                                  fontSize: 13.0,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text('Logout'),
                                            content: Text('Proceed to logout?'),
                                            actions: <Widget>[
                                              FlatButton(
                                                  child: Text('No'),
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false)),
                                              FlatButton(
                                                  child: Text('Yes'),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen()),
                                                    );
                                                  })
                                            ],
                                          ));
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.airport_shuttle,
                                    color: Colors.white,
                                  ),
                                  backgroundColor:
                                      Colors.green.withOpacity(0.9),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 13.0,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      // This will hold the newsfeed
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Newsfeed",
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    newsfeed()
                  ],
                );
              } else if (snapshot.data == "waiting") {
                //return a circular progress indicator
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // show search results if text is entered in the search field

                return ListView.builder(
                  itemCount: snapshot.data['definitions'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListBody(
                      children: <Widget>[
                        Container(
                          color: Colors.greenAccent,
                          child: ListTile(
                            //generate a leading image if the image url exists
                            leading: snapshot.data["definitions"][index]
                                        ["image_url"] ==
                                    null
                                ? null
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data["definitions"][index]
                                            ["image_url"]),
                                  ),
                            title: Text(_controller.text.trim() +
                                "(" +
                                snapshot.data["definitions"][index]["type"] +
                                ")"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data["definitions"][index]
                              ["definition"]),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // Newsfeed
  newsfeed() {
    return Container(
      child: FutureBuilder(
        future: _getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshots) {
          // first we check if snapshot.data is null or not
          if (snapshots.data == null) {
            return Container(
              child: Center(
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
              ),
            );
          } else {
            // snapshot will hold all data from the _getUsers() function
            return ListView.builder(
              itemCount: snapshots.data.length,
              // item builder is where we defune how each item in our list looks like

              itemBuilder: (BuildContext context, int index) {
                // use the index to access any value inside  our array
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshots.data[index].name),
                  ),
                  //  snapshot.data is a user object, so we access the name using .name
                  title: Text(snapshots.data[index].name),
                  subtitle: Text(snapshots.data[index].email),
                  // create a method to take to user detail page
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(snapshots.data[index])));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  // FutureBuilder
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

  //toast
  FlutterToast flutterToast;
  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    flutterToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
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
