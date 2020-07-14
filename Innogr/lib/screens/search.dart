import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatelessWidget {
  final getProperties;

  const SearchScreen({Key key, this.getProperties}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                onTap: () {},
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Search..."),
                  onSubmitted: (String place) {},
                ),
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  FontAwesomeIcons.slidersH,
                  color: Colors.black54,
                ),
              ),
            ],
          )),
    );
  }
}
