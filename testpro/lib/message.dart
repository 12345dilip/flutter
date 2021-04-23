import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testpro/config/upload_url.dart';

class Message extends StatefulWidget {

 @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  Map msg;

  getData() async {
    var response = await http
        .get(BaseUrl.message, headers: {"Accept": "application/json"});

    this.setState(() {
      final invoiceData = json.decode(response.body);
      msg = invoiceData['data'];
      print(msg);
    });
  }

    sendmessage(mes)async{
      final reqObj = {
           'comment': mes,
           'commentedBy': "607fef745fb0e93048e8bb9b",
           'commentedTo': "607fef745fb0e93048e8bb9b",
       };
       this.msg['comment'].add(reqObj);
 
final response = await http.post(BaseUrl.comment,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.msg));

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:
              IconButton(icon: Icon(Icons.arrow_back_sharp), onPressed: () {}),
          actions: [IconButton(icon: Icon(Icons.menu), onPressed: () {})],
          title: Text('Message'),
        ),
        body: Column(
          children: [
            ListView.builder(
                itemCount: this.msg.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(children: [
                    Container(
                      padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                      child:Align(
                      alignment: (Alignment.topRight),
              child: Container(
               decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (Colors.blue),
          ),
         padding: EdgeInsets.all(16),
                      child: Text(this.msg[index]['comment'],
                          style: TextStyle(fontSize: 15,color: Colors.white),),
        ),
      )
      ),
          ]);
     }
                ),
                 Stack(
                      children: <Widget>[
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
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                             sendmessage(
                                     msg,
                                  );

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
          ],mainAxisAlignment: MainAxisAlignment.end,
        ),
        );
  }
}
