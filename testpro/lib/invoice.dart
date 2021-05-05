import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testpro/config/upload_url.dart';
import 'package:http/http.dart' as http;
import 'package:testpro/invoice_details.dart';

class Invoice extends StatefulWidget {
  Invoice({this.argument});
  final Map argument;
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  List invoiceList;
  List fullinvoiceList;
  List _invoice;
  Map values;
  
  
  getData() async {
    var response = await http.get(BaseUrl.invoice + this.values['_id'],
        headers: {"Accept": "application/json"});
    this.setState(() {
      final invoiceData = json.decode(response.body);
      invoiceList = invoiceData['data'];
      fullinvoiceList = invoiceData['data'];
      print(invoiceList);
    });
  }

  @override
  void initState() {
    setState(() {
      this.values = this.widget.argument['values'];
     
    });
    
   print(this.invoiceList);
    
    super.initState();

    this.getData();
  }

  String chosenValue;
  String drop = 'All Invoice ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         //leading: Container(),
          title: DropdownButton(
            value: chosenValue,
            style:
                TextStyle(color: Colors.white, decorationColor: Colors.white),
            items: [
              'All Invoice',
              'Draft',
              'Pending',
              'Paid',
              
            ].map((String value) {
              return DropdownMenuItem(
                value: value,
                
                child: Text(
                  value,
                  style: TextStyle(color: Colors.black,fontSize: 20.0),
                ),
              );
            }).toList(),
            onChanged: (String value) { 
              
              drop = value;
             // chosenValue = value;
              print(value.toString());
              if (value == 'All Invoice') {
                setState(() {
                  invoiceList = fullinvoiceList;
                 
                 });
              } else {
                _invoice =  fullinvoiceList.where((i) => i['status'] == value).toList();
              setState(() {
                  invoiceList = _invoice; 
                 
                });
              }
              
            },
          hint: Text(this.drop.toString(),
          style: TextStyle(color: Colors.white,fontSize: 20.0,
          fontWeight: FontWeight.bold
          ),
             
            )
          ),
          backgroundColor: Colors.amber,
        ),
        body: invoiceList == null
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : ListView.separated(
                itemCount: this.invoiceList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => InvoiceDetails(
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
                                Text((this.invoiceList[index]['invoice'])
                                    .toString()),
                                Text('₹ ' +
                                    (this.invoiceList[index]['totalAmount'])
                                        .toString()),
                              ],
                            ),
                            if (this.invoiceList[index]['expiryDate'] == null)
                              Text((dateFormat(this.invoiceList[index]
                                      ['recurringstartDate']) +
                                  ' - ' +
                                  dateFormat(this.invoiceList[index]
                                      ['recurringendDate'])))
                            else
                              Text((dateFormat(
                                      this.invoiceList[index]['invoiceDate']) +
                                  ' - ' +
                                  dateFormat(
                                      this.invoiceList[index]['expiryDate']))),
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

dateFormat(dateFormat) {
  return DateUtil().formattedDate(DateTime.parse(dateFormat));
}

class DateUtil {
  static const DATE_FORMAT = 'dd/MM/yyyy';
  String formattedDate(DateTime dateTime) {
    return DateFormat(DATE_FORMAT).format(dateTime);
  }
}