import 'package:expense_tracker/modules/dashboard/screens/HomeScreen.dart';
import 'package:expense_tracker/modules/dashboard/screens/authenticate/login_page.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/dashboard/screens/authenticate/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runApp( MyApp(token : token));
}

class MyApp extends StatelessWidget {
  final String? token ;

  const MyApp({
    @required this.token,
    Key? key,
  }) :
    super(key : key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: (token != null && JwtDecoder.isExpired(token!) == false) ? HomeScreen(token: token) : LoginPage(),
    );
  }
}

