//import 'dart:html';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);
  @override
  _SettingState createState() => _SettingState();
}

/// This is the stateless widget that the main application instantiates.
class _SettingState extends State<Settings> {
  bool _dark;
  @override
  void initState() {
    super.initState();
    _dark = false;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  static final String path = "lib/screens/settings.dart";
  @override
  Widget build(BuildContext context) {
    return Theme(
        isMaterialAppTheme: true,
        data: ThemeData(
          brightness: _getBrightness(),
        ),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            elevation: 0,
            brightness: _getBrightness(),
            iconTheme:
                IconThemeData(color: _dark ? Colors.white : Colors.black),
            backgroundColor: Colors.green.shade200,
            title: Text(
              'Settings',
              style: TextStyle(color: _dark ? Colors.white : Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(FontAwesomeIcons.moon),
                onPressed: () {
                  setState(() {
                    _dark = !_dark;
                  });
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.green,
                  child: ListTile(
                    onTap: () {
                      // Open edit profile
                    },
                    title: Text(
                      "Hafise Alyanga",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Cirle avatar holds a child widget called CatchedNetWorkImage
                    leading: CircleAvatar(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://avatars2.githubusercontent.com/u/41443166?s=120&v=4",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.lock_outline,
                          color: Colors.lightGreen,
                        ),
                        title: Text("Change Password"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          // open change password
                        },
                      ),
                      buildDivider(),
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.language,
                          color: Colors.lightGreen,
                        ),
                        title: Text("Change Language"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          // open change language
                        },
                      ),
                      buildDivider(),
                      ListTile(
                        leading:
                            Icon(Icons.location_on, color: Colors.lightGreen),
                        title: Text("Change Location"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          // open change location
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Notification Settings",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen,
                  ),
                ),
                SwitchListTile(
                    dense: true,
                    activeColor: Colors.lightGreen,
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text("Receive notifications"),
                    onChanged: (val) {}),
                SwitchListTile(
                    dense: true,
                    activeColor: Colors.lightGreen,
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text("Receive Newsletters"),
                    onChanged: (val) {}),
              ],
            ),
          ),
        ));
  }
}

// Function to return a container
Container buildDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey.shade400,
  );
}
