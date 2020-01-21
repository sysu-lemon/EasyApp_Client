import 'package:flutter/material.dart';
import 'package:easy_app_client/common/Global.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = new GlobalKey<ScaffoldState>();

  String _username, _password= "";
  bool _isObsecure = true;
  Color _eyeColor = Colors.grey;

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
            SizedBox(height: 50),
            buildUsernameTextFormField(context),
            SizedBox(height: 30),
            buildPasswordTextFormField(context),
            SizedBox(height: 50),
            buildSignInButton(context),
            SizedBox(height: 50),
            buildSignUpButton(context),
          ],
        ),
      ),
    );
  }

  Padding buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        '(ง •_•)ง SignIn',
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
      obscureText: _isObsecure,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: _eyeColor,
          ),
          onPressed: () {
            setState(() {
              _isObsecure = !_isObsecure;
              _eyeColor = _isObsecure ? Colors.grey : Theme.of(context).iconTheme.color;
            });
          },
        ),
      ),
      validator: (String v) {
        if (v.isEmpty) return "please input the password";
        return null;
      },
    );
  }

  Align buildSignInButton(BuildContext context) {
    return Align(
        child: SizedBox(
      height: 50,
      width: 300,
      child: RaisedButton(
        child: Text('SignIn'),
        shape: StadiumBorder(side: BorderSide()),
        onPressed: () {
          _formKey.currentState.save();
          if (!_formKey.currentState.validate()) return;
          Global.dio.post(
            "/login",
            data: {
              "username": _username,
              "password": _password,
            },
          ).then((res) {
            Global.setToken(res.data["data"]["token"]);
            Navigator.pushReplacementNamed(context, "/", arguments: _username);
            _scaffoldkey.currentState.showSnackBar(SnackBar(
              content: Text("success"),
            ));
          }).catchError((err) {
            _scaffoldkey.currentState.showSnackBar(SnackBar(
              content: Text("username or password wrong"),
            ));
          });
        },
      ),
    ));
  }

  Align buildSignUpButton(BuildContext context) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('no account?'),
          GestureDetector(
            child: Text(
              'click to signUp',
              style: TextStyle(color: Colors.green),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/signUp');
            },
          )
        ],
      ),
    );
  }
}
