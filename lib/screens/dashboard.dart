import 'package:flutter/material.dart';
import 'package:auth_demo/services/authenticate.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
            child: RaisedButton(
              child: Center(
                child: Text("Sign Out"),
              ),
              onPressed: (){
                Authenticate().signout();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: RaisedButton(
              child: Center(
                child: Text("Verify"),
              ),
              onPressed: (){
                Authenticate().handleAuth();
              },
            ),
          ),
        ],
      ),
    );
  }
}