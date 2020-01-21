import 'package:easy_app_client/common/Global.dart';
import 'package:flutter/material.dart';
import 'routes/HomePage.dart';
import 'routes/SignInPage.dart';
import 'routes/SignUpPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((v) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) => HomePage(),
        '/signIn': (context) => SignInPage(),
        '/signUp': (context) => SignUpPage(),
      },
    );
  }
}