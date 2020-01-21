import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static Dio dio = Dio();
  static String token;

  static Future init() async {
    dio.options.baseUrl = "http://193.112.252.88:8080/api/v1";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;

    token = await _getToken();
  }

  static Future<bool> checkToken() async{
    print(token);
    try {
      Response res = await dio.get(
        '/token',
        options: Options(
          headers: {
            "token": token,
          },
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? '';
  }

  static void setToken(String token) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    Global.token = await _getToken();
  }

  static void delToken() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Global.token = await _getToken();
  }
}
