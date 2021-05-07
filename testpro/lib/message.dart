import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testpro/config/upload_url.dart';
import 'package:testpro/first_page.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';

dateFormat(dateFormat) {
  if (dateFormat != null) {
    return DateUtil().formattedDate(DateTime.parse(dateFormat));
  } else {
    var thisInstant = new DateTime.now();
    return DateUtil().formattedDate(DateTime.parse(thisInstant.toString()));
  }
}

class DateUtil {
  static const DATE_FORMAT = 'dd/MM/yyyy hh:mm';
  String formattedDate(DateTime dateTime) {
    return DateFormat(DATE_FORMAT).format(dateTime);
  }
}

class Message extends StatefulWidget {
  Message({this.argument});

  final Map argument;
  // final String company;
  // final Map val;
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  List msg;
   String company;
   Map val;
  bool textChat = false;

  getData() async {
    print(BaseUrl.message + this.company);
    var response = await http.get(BaseUrl.message + this.company,
        headers: {"Accept": "application/json"});

    this.setState(() {
      final invoiceData = json.decode(response.body);
      msg = invoiceData['data'];
      print('company');
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
      'commentedBy': this.val["_id"],
      'commentedTo': this.company,
      'company': this.company,
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

    setState(() {
      this.val = this.widget.argument['val'];
      this.company = this.widget.argument['company'];

    });

    print('-------------------------------------------------------');
    print(this.val);
    print(this.company);
    print('-------------------------------------------------------');

    super.initState();
    this.getData();
  }

  setAxis(data) {
    if (data == this.company) {
      return MainAxisAlignment.start;
     }else{ 
      return MainAxisAlignment.end;
     }
    
  }


  Color getColor(data) {
  if (data == this.company) {
    return Colors.grey;
  } else {
    return Colors.tealAccent.shade700;
  }
}

final value = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.tealAccent.shade700,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => FirstPage(null, null)));
            }),
        title: Text('Message'),
      ),
      body: Stack(
        children: [
          msg == null
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    child: ListView.builder(
                        itemCount: this.msg.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 80),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                              mainAxisAlignment:
                                setAxis(this.msg[index]['commentedBy'],),
                                
                              children: [
                              Flexible(
                                        child: Container(
                                      padding: EdgeInsets.only(
                                          left: 14, right: 14, top: 10, bottom: 10),
                                      //child: Align(
                                        //alignment: (Alignment.topLeft),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: getColor(this.msg[index]['commentedBy'],)
                                          ),
                                          padding: EdgeInsets.all(16),
                                          child: GestureDetector(
                                            onLongPress: () {
                                              setState(() {
                                                textChat = true;
                                              });
                                            },
                                            
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  this.msg[index]['comment'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      
                                                      ),
                                                ),
                                                Text(
                                                  dateFormat(
                                                      this.msg[index]['createdAt']),
                                                  style: TextStyle(
                                                      //fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    //fontFamily: 'Poppins',
                                                   // fontStyle: FontStyle.italic
                                                    

                                                ),),
                                                //  Text(
                                                //   'hi dilip',
                                                //   style: TextStyle(
                                                //     //  fontWeight: FontWeight.bold,
                                                //       color: Colors.white,
                                                //     fontFamily: 'Poppins',
                                                   // fontStyle: FontStyle.italic
                                                  //),)
                                                // Text(
                                                //   dateFormat(this.msg[index]['createdAt']),
                                                //   style:
                                                //       TextStyle(fontSize: 8, color: Colors.white),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                             // ),
                             
                                if (textChat)
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                title:
                                                    Text('Do you want Delete'),
                                                actions: [
                                                  FlatButton(
                                                      onPressed: () {
                                                       Navigator.of(context, rootNavigator: true).pop(true);
                                                      },
                                                      child: Text('No')),
                                                  FlatButton(
                                                      onPressed: () {
                                                        deleteData(
                                                            this.msg[index]
                                                                ['_id'],
                                                            index);
                                                        textChat = false;
                                                        Navigator.of(context, rootNavigator: true).pop(true);
                                                      },
                                                      child: Text('Yes'))
                                                ],
                                              ));
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
                    backgroundColor: Colors.tealAccent.shade700,
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
