import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:easy_app_client/routes/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_app_client/common/Global.dart';

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
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              Text("token: " + Global.token),
              SizedBox(height: 100),
              RaisedButton(
                child: Text("sign out"),
                onPressed: () {
                  Global.delToken();
                  Navigator.pushReplacementNamed(context, "/signIn");
                },
              ),
            ],
          ),
        )
    );
  }
}
