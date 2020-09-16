import 'package:drarogyam/screens/authenticate/authenticate.dart';
import 'package:drarogyam/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drarogyam/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if(user == null){
    return Authenticate();
    }else{
      return Home();
    }
  }
}