import 'package:flutter/material.dart';
import 'package:easy_app_client/common/Global.dart';
import 'package:easy_app_client/common/Permission.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Global.checkToken().then((v) {
      if (v == false)Navigator.pushReplacementNamed(context, "/signIn");
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.red),
            onPressed: () {
              Global.delToken();
              Navigator.pushReplacementNamed(context, "/signIn");
            },
          )
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              Text("token: " + Global.token),
              SizedBox(height: 100),
              RaisedButton(
                child: Text("request permission"),
                onPressed: () {
                  Permission.requestPermission();
                },
              )
            ],
          ),
        )
    );
  }
}
