import 'package:drarogyam/models/user.dart';
import 'package:drarogyam/services/database.dart';
import 'package:drarogyam/utilities/loading.dart';
import 'package:flutter/material.dart';
import 'package:drarogyam/services/auth.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:drarogyam/services/xray.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  String result = "123312";

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        this.result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.result = "Camera permission was denied";
        });
      } else {
        setState(() {
          this.result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        this.result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        this.result = "Unknown Error $ex";
      });
    }
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: new AppBar(
        // backgroundColor: Color.fromRGBO(1, 177 , 226, 1),
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color.fromRGBO(68, 214, 245, 1),
              Color.fromRGBO(1, 177, 226, 1)
            ],
          )),
        ),
        iconTheme: new IconThemeData(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF398AE5),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "Hello Doctor",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 40.0,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Color(0xFF398AE5),
              ),
              label: Text(
                "Log out",
                style: TextStyle(
                  color: Color(0xFF398AE5),
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 0.0),
                child: Image.asset("assets/bg.png"),
              ),
            ],
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 200.0),
              width: 200,
              child: RaisedButton(
                onPressed: _scanQR,
                color: Color.fromRGBO(1, 177, 226, 1),
                child: Text(
                  "Scan Qr",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 20),
                ),
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          Container(
            child: StreamBuilder<UserData>(
                stream: DatabaseService(uid: result).userData,
                builder: (context, snapshot) {
                  UserData userData = snapshot.data;
                  if (snapshot.hasData) {
                    return Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 350,
                          ),
                          SizedBox(height: 80),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Patient Id : ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(1, 177, 226, 1),
                                    fontFamily: "Montserrat",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                          SizedBox(height: 20),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Score Value : ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(1, 177, 226, 1),
                                    fontFamily: "Montserrat",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                          SizedBox(height: 20),
                          Row(children: <Widget>[
                            Expanded(
                                child: Text(
                                  "TB Patient : ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(1, 177, 226, 1),
                                    fontFamily: "Montserrat",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  userData.flag,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(1, 177, 226, 1),
                                    fontFamily: "Montserrat",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 25.0),
                            width: 200,
                            child: RaisedButton(
                              onPressed: () {
                                print(result);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => XrayScan(result: result)));
                              },
                              color: Color.fromRGBO(1, 177, 226, 1),
                              child: Text(
                                "Scan X-ray",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                    fontSize: 20),
                              ),
                              padding: EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 450),
                        Center(
                          child: Text(
                            "Qr was not scanned or didn't have valid data ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(1, 177, 226, 1),
                              fontFamily: "Montserrat",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
