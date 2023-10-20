import 'package:flutter/material.dart';
import 'package:weather_app_flutter_mvvm/main.dart';

import '../api_key_page.dart';

class Exception503 implements Exception{
  Exception503(){
    Navigator.of(GlobalKeyHelper.navigatorKey.currentContext!).popUntil((route) => route.isFirst);
    Navigator.of(GlobalKeyHelper.navigatorKey.currentContext!).push(MaterialPageRoute(builder: (context) => ApiKeyPage(),));
  }
}