import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:drarogyam/screens/decision.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class XrayScan extends StatefulWidget {
  String result;

  XrayScan({Key key, @required this.result}) : super(key: key);
  @override
  _XrayScanState createState() => _XrayScanState(result);
}

class _XrayScanState extends State<XrayScan> {
  String result;

  _XrayScanState(this.result);
  File pickedImage;
  bool isImageNull = false;
  Dio dio = new Dio();
  String resp;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      isImageNull = true;
      pickedImage = image;
    });
  }

  // static ocr(File image) async {
  //   var url = '${'http://13.88.219.143:5000/predict'}ocr';
  //   var bytes = image.readAsBytesSync();
  //   var response = await http.post(
  //     url,
  //     headers: {"Content-Type": "multipart/form-data"},
  //     body: {"image": bytes},
  //   );
  //   return response;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: new AppBar(
        backgroundColor: Colors.white12,
        elevation: 0.0,
        iconTheme: new IconThemeData(
          color: Color(0xFF398AE5),
        ),
      ),
      body: Column(
        children: <Widget>[
          isImageNull
              ? Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: FileImage(pickedImage),
                          fit: BoxFit.cover,
                        )),
                      ),
                    ],
                  ),
                )
              : Container(),
          SizedBox(
            height: 90,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            width: 300,
            child: RaisedButton(
              onPressed: getImage,
              color: Color.fromRGBO(1, 177, 226, 1),
              child: Text(
                "Click to take the image",
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
          SizedBox(
            height: 30.0,
          ),
          RaisedButton(
            child: Text("Scan Xray"),
            onPressed: () async {
              try {
                // var stream = new http.ByteStream(
                //     DelegatingStream.typed(pickedImage.openRead()));
                // // get file length
                // var length = await pickedImage.length();

                // // string to uri
                // var uri = Uri.parse("http://13.88.219.143:5000/predict");

                // // create multipart request
                // var request = new http.MultipartRequest("POST", uri);

                // // multipart that takes file
                // var multipartFile = new http.MultipartFile(
                //     'file', stream, length,
                //     filename: basename(pickedImage.path));

                // // add file to multipart
                // request.files.add(multipartFile);

                // // send
                // var response = await request.send();
                // print(response.statusCode);

                // // listen for response
                // response.stream.transform(utf8.decoder).listen((value) {
                //   print(value);
                // });
                //ocr(pickedImage);
                FormData formData = FormData.fromMap(
                    {"image": await MultipartFile.fromFile(pickedImage.path)});
                Response response;
                response = await dio.post("http://13.88.219.143:5000/predict",
                    data: formData);
                // response.stream.transform(utf8.decoder).listen((value) {
                resp = response.toString();
                print(resp);
                print(result);
              } catch (e) {
                print(e);
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Decision(result: result, response: resp)));
            },
            elevation: 5.0,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
