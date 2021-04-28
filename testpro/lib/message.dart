import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testpro/config/upload_url.dart';
import 'package:testpro/first_page.dart';

class Message extends StatefulWidget {
  Message({
    this.val,
  });
  final Map val;
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  List msg;

  bool textChat = false;

  getData() async {
    var response = await http
        .get(BaseUrl.message, headers: {"Accept": "application/json"});

    this.setState(() {
      final invoiceData = json.decode(response.body);
      msg = invoiceData['data'];
      print(msg);
    });
  }

  deleteData(id, index) async {
     setState(() {
      this.msg.removeAt(index);
       
    });
    final response = await http.delete(BaseUrl.comment + id,
        headers: {'Content-Type': 'application/json; charset=UTF-8'});

    var res = response.body;

    
    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }

  sendmessage(mes) async {
    final reqObj = {
      'comment': mes,
      'commentedBy': "607fef745fb0e93048e8bb9b",
      'commentedTo': "607fef745fb0e93048e8bb9b",
    };
    setState(() {
      this.msg.add(reqObj);
    });
    final response = await http.post(BaseUrl.comment,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(reqObj));

    var res = response.body;
    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  final value = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => FirstPage(null, null)));
            }),
        actions: [IconButton(icon: Icon(Icons.menu), onPressed: () {})],
        title: Text('Message'),
      ),
      body: Stack(
     
          children: [
           
             SingleChildScrollView(reverse: true,
                            child: Container(
                  child: ListView.builder(
                  
                      itemCount: this.msg.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 80),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment: (Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (Colors.blue),
                                ),
                                padding: EdgeInsets.all(16),
                                child: GestureDetector(
                                  onLongPress: () {
                                    setState(() {
                                      textChat = true;
                                    });
                                  },
                                 
                                  child: Text(
                                    this.msg[index]['comment'],
                                    style:
                                        TextStyle(fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (textChat)
                            IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  deleteData(this.msg[index]['_id'], index);
                                  textChat=false;
                                },
                                
                                )
                        ]);
                      }),
                ),
             ),
           
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                              controller: value,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              sendmessage(value.text);
                              value.clear();
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          );
  }
}
