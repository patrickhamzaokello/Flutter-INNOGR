import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Resources extends StatefulWidget {
  const Resources({Key key}) : super(key: key);

  @override
  _ResourcesSate createState() => _ResourcesSate();
}

class _ResourcesSate extends State<Resources> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Resources'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.perm_device_information),
                  text: 'Support Center',
                ),
                Tab(
                  icon: Icon(Icons.group_work),
                  text: 'Projects',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Load the support center's information
              SupportCenter(),
              // LOad information on projects
              Projects(),
            ],
          ),
        ),
      ),
    );
  }
}

// Code for the support center tab
class SupportCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("Support Center Information!")],
        ),
      ),
    );
  }
}

// Code for the projects tab
class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("Project Information!")],
        ),
      ),
    );
  }
}
