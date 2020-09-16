import 'package:drarogyam/models/user.dart';
import 'package:drarogyam/services/database.dart';
import 'package:flutter/material.dart';
import 'package:drarogyam/screens/home/home.dart';
import 'package:provider/provider.dart';

class Decision extends StatefulWidget {
  String result, response;
  Decision({Key key, @required this.result, @required this.response})
      : super(key: key);
  @override
  _DecisionState createState() => _DecisionState(result, response);
}

class _DecisionState extends State<Decision> {
  String result, response;
  final _formKey = GlobalKey<FormState>();
  _DecisionState(this.result, this.response);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white12,
          elevation: 0.0,
          iconTheme: new IconThemeData(
            color: Color(0xFF398AE5),
          ),
        ),
        body: StreamBuilder<UserData>(
            stream: DatabaseService(uid: result).userData,
            builder: (context, snapshot) {
              UserData userData = snapshot.data;
              return Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Patient Id  ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(1, 177, 226, 1),
                            fontFamily: "Montserrat",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        ":",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(1, 177, 226, 1),
                          fontFamily: "Montserrat",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          userData.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(1, 177, 226, 1),
                            fontFamily: "Montserrat",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Score Value",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(1, 177, 226, 1),
                            fontFamily: "Montserrat",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        ":",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(1, 177, 226, 1),
                          fontFamily: "Montserrat",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          userData.score,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(1, 177, 226, 1),
                            fontFamily: "Montserrat",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Xray Value",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(1, 177, 226, 1),
                            fontFamily: "Montserrat",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        ":",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(1, 177, 226, 1),
                          fontFamily: "Montserrat",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          response.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(1, 177, 226, 1),
                            fontFamily: "Montserrat",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  Text(
                    "TB Patient verification",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(1, 177, 226, 1),
                      fontFamily: "Montserrat",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: result).updateUserData(
                                userData.name,
                                userData.age,
                                userData.score,
                                'true',
                                userData.lat,
                                userData.long);
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        color: Colors.red,
                        child: Text(
                          "Yes",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontSize: 20),
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      SizedBox(width: 20),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: result).updateUserData(
                                userData.name,
                                userData.age,
                                userData.score,
                                'false',
                                userData.lat,
                                userData.long);
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        color: Colors.green,
                        child: Text(
                          "No",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontSize: 20),
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
