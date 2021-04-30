import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testpro/first_page.dart';
import 'package:testpro/signin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
 
  runApp(new MaterialApp(
    
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final storage = FlutterSecureStorage();
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blue,
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (!snapshot.hasData) return CircularProgressIndicator();
            if (snapshot.data != "") {
              var str = snapshot.data;
              var jwt = str.split(".");
              if (jwt.length != 3) {
                return Signin();
              } else {
                var payload = json.decode(
                    ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                    .isAfter(DateTime.now())) {
                  return FirstPage(str, payload);
                } else {
                  return Signin();
                }
              }
            } else {
              return Signin();
            }
          }),
    );
  }
}
