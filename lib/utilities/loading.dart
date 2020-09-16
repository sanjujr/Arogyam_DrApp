import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          
          Center(
              child: SpinKitRotatingCircle(
            color: Color(0xFF398AE5),
            size: 75.0,
          )),
        ],
      ),
    );
  }
}
