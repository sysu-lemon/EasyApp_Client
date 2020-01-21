import 'package:flutter/material.dart';
import 'package:easy_app_client/common/Global.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = new GlobalKey<ScaffoldState>();

  String _username, _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldkey,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(height: 80),
            buildTitle(context),
            SizedBox(height: 30),
            buildUsernameTextFormField(context),
            SizedBox(height: 30),
            buildPasswordTextFormField(context),
            SizedBox(height: 30),
            buildRePasswordTextFormField(context),
            SizedBox(height: 50),
            buildSignUpButton(context),
            SizedBox(height: 50),
            buildSignInButton(context),
          ],
        ),
      ),
    );
  }

  Padding buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        '(ง •_•)ง SignUp',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }

  TextFormField buildUsernameTextFormField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _username = value,
      decoration: InputDecoration(
        labelText: 'Username',
        prefixIcon: Icon(Icons.person),
      ),
      validator: (String v) {
        if (v.isEmpty) return "please input the username";
        return null;
      },
    );
  }

  TextFormField buildPasswordTextFormField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock),
      ),
      validator: (String v) {
        if (v.isEmpty) return "please input the password";
        return null;
      },
    );
  }

  TextFormField buildRePasswordTextFormField(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'RePassword',
        prefixIcon: Icon(Icons.lock),
      ),
      validator: (String v) {
        if (v.isEmpty) return "please input the password again";
        if (v != _password) return "password not correct";
        return null;
      },
    );
  }

  Align buildSignUpButton(BuildContext context) {
    return Align(
        child: SizedBox(
      height: 50,
      width: 300,
      child: RaisedButton(
        child: Text('SignUp'),
        shape: StadiumBorder(side: BorderSide()),
        onPressed: () {
          _formKey.currentState.save();
          if (!_formKey.currentState.validate()) return;
          Global.dio.post(
            "/users",
            data: {
              "username": _username,
              "password": _password,
            },
          ).then((res) {
            _scaffoldkey.currentState.showSnackBar(SnackBar(
              content: Text("success"),
            ));
            Navigator.pop(context);
          }).catchError((err) {
            _scaffoldkey.currentState.showSnackBar(SnackBar(
              content: Text("user existed"),
            ));
          });
        },
      ),
    ));
  }

  Align buildSignInButton(BuildContext context) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('have account?'),
          GestureDetector(
            child: Text(
              'click to signIn',
              style: TextStyle(color: Colors.green),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
