import 'package:drarogyam/screens/wrapper.dart';
import 'package:drarogyam/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drarogyam/models/user.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF398AE5),
          accentColor: Colors.white,
        ),
        home: Wrapper(),
      ),
    );
  }
}
