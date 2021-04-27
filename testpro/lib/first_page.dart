import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testpro/config/upload_url.dart';
import 'package:testpro/home_page.dart';
import 'package:testpro/invoice.dart';
import 'package:testpro/message.dart';
import 'package:testpro/product.dart';
import 'package:testpro/upload.dart';
import 'package:http/http.dart' as http;

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}
class _FirstPageState extends State<FirstPage> {

  Map data;
int selectedIndex = 0;
 Future getData() async {
    var response = await http.get(
        BaseUrl.homePage,
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
    }
@override
  void initState() {
    super.initState();
    this.getData();
  }


 
@override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       child: Column(mainAxisAlignment: MainAxisAlignment.end,
         children: [
           Card(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                
                  Column(
                    children: [
                      IconButton(icon: Icon(Icons.home), onPressed: (){
                }),Text('Home'),
                    ],
                  ),
                 Column(
                 children: [
                   IconButton(icon: Icon(Icons.album_outlined), onPressed: (){
                       Navigator.push(context, new MaterialPageRoute(builder: (context) => Invoice(
                        )
                                 )
                                 );
                      }),Text('Invoice'),
                 ],
               ),
              Column(
                   children: [
                     IconButton(icon: Icon(Icons.upload_file), onPressed: (){
                       
                         Navigator.push(context, new MaterialPageRoute(builder: (context) => Upload(
                                     prod: data["data"][0],
                                 )
                                 )
                                 );
                      }),Text('Upload'),
                   ],
                 ),
                Column(
                 children: [
                   IconButton(icon: Icon(Icons.person), onPressed: (){
                         Navigator.push(context, new MaterialPageRoute(builder: (context) => Product(
                                     prod: data["data"][0],
                                 )));
                      }),Text('Profile'),
                 ],
               ),
              Column(
                  children: [
                    IconButton(icon: Icon(Icons.message), onPressed: (){
                       Navigator.push(context, new MaterialPageRoute(builder: (context) => Message(
                        )
                                 )
                                 );
                      }),Text('Message'),
                  ],
                ),
                ],
             ),
           ),
         ],
       ),
      ),
     );
  }
}