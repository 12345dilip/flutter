import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testpro/config/upload_url.dart';
import 'package:http/http.dart' as http;

import 'package:testpro/invoice_details.dart';

class Invoice extends StatefulWidget {
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  List invoiceList;

  getData() async {
    var response = await http
        .get(BaseUrl.invoice, headers: {"Accept": "application/json"});

    this.setState(() {
      final invoiceData = json.decode(response.body);
      invoiceList = invoiceData['data'];
      print(invoiceList);
    });
  }
@override
  void initState() {
    super.initState();
    this.getData();
  }
 String chosenValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
          title: DropdownButton( 
            value: chosenValue,
            style:
                TextStyle(color: Colors.white, decorationColor: Colors.white),
            items:[
    'Invoice 1',
    'Invoice 2',
    'Invoice 3',
    'Invoice 4',
    'Invoice 5',
   
  ].map((String value) {
    return DropdownMenuItem(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.black),),
    );
  }).toList(),
    onChanged: (String value) {
    setState(() {
      chosenValue = value;
    });
  },
            hint: Text(
              'All Invoice',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
          backgroundColor: Colors.amber,
        ),
        body: ListView.separated(
          itemCount: this.invoiceList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                 Navigator.push(context, new MaterialPageRoute(builder: (context) => InvoiceDetails(
                   name: this.invoiceList[index],
                  
                 )));
              },
                          
              child: Container(
                
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text((this.invoiceList[index]['invoice']).toString()),
              


                          Text('₹ '+(this.invoiceList[index]['totalAmount']).toString()),
                        ],
                      ),
                      if (this.invoiceList[index]['expiryDate'] == null)
                        Text((dateFormat(this.invoiceList[index]['recurringstartDate'])+' - '+ dateFormat(this.invoiceList[index]['recurringendDate'])))
                      else
                        
                       Text((dateFormat(this.invoiceList[index]['invoiceDate']) +' - '+ dateFormat(this.invoiceList[index]['expiryDate']))),
                        
                   
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ));
  }
}

dateFormat(dateFormat){  
return DateUtil().formattedDate(DateTime.parse(dateFormat));
}

class DateUtil {
  static const DATE_FORMAT = 'dd/MM/yyyy';
  String formattedDate(DateTime dateTime) {
    return DateFormat(DATE_FORMAT).format(dateTime);
  }
}