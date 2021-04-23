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
 List allScreens =[
    HomePage(),
    Invoice(),
    Upload(),
    Product(),
    Message(),
  
  ];


  // List messages = [
  //     {
  //        "_id":"60812e418436fd29a0c24ecd",
  //        "comment":"Hi",
  //        "commentedBy": "607fef745fb0e93048e8bb9b",
  //        "commentedTo":"607fef745fb0e93048e8bb9b",
  //        "createdAt":"2021-04-22T08:05:21.060Z",
  //        "__v":0
  //     },
  //     {
  //        "_id":"608271698436fd29a0c24ee1",
  //        "comment":"How are you",
  //         "commentedBy": "607fef745fb0e93048e8bb9b",
  //        "commentedTo":"607fef745fb0e93048e8bb9b",
  //        "createdAt":"2021-04-23T07:04:09.473Z",
  //        "__v":0
  //     }
  //  ];
 
@override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
         child: allScreens.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.album_outlined),
            label: 'Invoice',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon:  IconButton(icon: Icon(Icons.upload_file), onPressed: (){
              print(data["data"][0]);
               Navigator.push(context, new MaterialPageRoute(builder: (context) => Upload(
                           prod: data["data"][0],
                       )
                       )
                       );
            }),
            label: 'upload',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: IconButton(icon: Icon(Icons.person), onPressed: (){
               Navigator.push(context, new MaterialPageRoute(builder: (context) => Product(
                           prod: data["data"][0],
                       )));
            }),
            label: 'Product',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
            backgroundColor: Colors.pink,
          ),
        ],
        onTap: (index) {
          setState(() {
            print(index.runtimeType);
            selectedIndex = index;
          });
        },
        
    ));
  }
}