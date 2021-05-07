import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testpro/config/upload_url.dart';
import 'package:testpro/invoice.dart';
import 'package:testpro/message.dart';
import 'package:testpro/product.dart';
import 'package:testpro/signin.dart';
import 'package:testpro/upload.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testpro/string.dart';

class FirstPage extends StatefulWidget {
  FirstPage(this.jwt, this.payload);

  factory FirstPage.fromBase64(String jwt) => FirstPage(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Map data;
  int selectedIndex = 0;
  Future getData() async {
    print(this.widget.payload);
    var response = await http.get(BaseUrl.homePage + this.widget.payload['_id'],
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

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    child: FlatButton.icon(
                      label: Container(
                        child: Text('Upload'),
                      ),
                      icon: Icon(Icons.upload_file),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Upload(
                                      prod: data["data"][0],
                                    )));
                      },
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    child: FlatButton.icon(
                      label: Container(
                        child: Text('Profile'),
                      ),
                      icon: Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Product(
                                      prod: data["data"][0],
                                    )));
                      },
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    child: FlatButton.icon(
                        label: Container(
                          child: Text('LOG OUT'),
                        ),
                        icon: Icon(Icons.logout),
                        onPressed: () async {
                          storage.delete(key: "jwt");
                          var jwt = await storage.read(key: "jwt");
                          print(jwt);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signin()));
                        }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          child: Column(children: [
            homepage(),
          ]),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //  Divider(),
            Builder(
                builder: (context) =>  Container(
                  height:50.0,
                   padding: const EdgeInsets.only(top: 5.0,),
                        color: Colors.white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Column(
                                    children: [
                                      Icon(
                                            Icons.home,
                                            color: Colors.tealAccent.shade700,
                                          ),
                                          Text('Home',
                                          style: TextStyle(
                                            color: Colors.tealAccent.shade700,
                                          )),
                                    ],
                                  ),
                              ),
                            
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(
                                                context, INVOICE_PAGE,
                                                arguments: {
                                                  'values': this.widget.payload
                                                });
                                },
                                    child: Container(
                                  
                                  child: Column(
                                    children: [
                                     Icon(Icons.album_outlined),
                                     Text('Invoice'),
                                     
                                    ],
                                  ),
                                ),
                              ),
                               GestureDetector(
                                onTap: (){
                                 Navigator.pushNamed(
                                            context,
                                            MESSAGE_PAGE,
                                            arguments: {
                                              'val': this.widget.payload,
                                              'company': data['data'][0]
                                                  ['createdBy']
                                            },
                                          );
                                },
                                    child: Container(
                                  
                                  child: Column(
                                    children: [
                                     Icon(Icons.message),
                                     Text('Message'),
                                     
                                    ],
                                  ),
                                ),
                              ),

                               GestureDetector(
                                onTap: (){
                                 Scaffold.of(context)
                                            .openEndDrawer();
                                },
                                    child: Container(
                                  
                                  child: Column(
                                    children: [
                                     Icon(Icons.settings),
                                     Text('Settings'),
                                     
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
          ],
        ),
      ]),
    );
  }
}

homepage() {
  return SingleChildScrollView(
      child: Container(
    // decoration: BoxDecoration(
    //   boxShadow: [
    //     BoxShadow(
    //       color: Colors.grey.withOpacity(0.5),
    //       spreadRadius: 5,
    //       blurRadius: 20,
    //       offset: Offset(0, 2),
    //     ),
    //   ],
    // ),
    child: Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 40.0, bottom: 10.0),
            height: 300.0,
            child: Card(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Half yearly sales analysis'),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                        dataSource: <SalesData>[
                          SalesData('Jan', 35),
                          SalesData('Feb', 28),
                          SalesData('Mar', 34),
                          SalesData('Apr', 32),
                          SalesData('May', 40)
                        ],
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ]),
            ),
          ),
        ),
        buildGrid(),
        slideshow(),
      ],
    ),
  ));
}

buildGrid() {
  return Container(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
    child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            height: 120.0,
            width: 166.0,
            child: Card(
              color: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Stack(
                // alignment: Alignment.topLeft,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 25.0, left: 25.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.money,
                              color: Colors.white,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                'Total Paid',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 27.0, bottom: 20.0, top: 5.0),
                            child: Text(
                              '6500',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 120.0,
            width: 166.0,
            child: Card(
              color: Colors.tealAccent.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Stack(
                //alignment: Alignment.topLeft,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 25.0, left: 25.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.money,
                              color: Colors.white,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                'Pending',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 27.0, bottom: 20.0, top: 5.0),
                          child: Text(
                            '2300',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.only(top: 9.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              height: 120.0,
              width: 166.0,
              child: Card(
                color: Colors.purple.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Stack(
                  // alignment: Alignment.topLeft,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 25.0, left: 25.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.money,
                                color: Colors.white,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  'Invoice',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 27.0, bottom: 20.0, top: 5.0),
                              child: Text(
                                '10',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 120.0,
              width: 166.0,
              child: Card(
                color: Colors.pinkAccent.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Stack(
                  //alignment: Alignment.topLeft,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 25.0, left: 25.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.money,
                                color: Colors.white,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  'Message',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 27.0, bottom: 20.0, top: 5.0),
                            child: Text(
                              '23',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}

slideshow() {
  return Container(
    padding: const EdgeInsets.only(top: 10.0, bottom: 40, left: 10),
    height: 120.0,
    width: 500.0,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(
            width: 260.0,
            child: Card(
              child: SingleChildScrollView(
                child: Container( padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                            'Notification Bar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                      Text(
                            'Having a container fit the size of the context flutte,'),
                    ],
                  ),
                ),
              ),
            )),
        Container(
          width: 260.0, 
          child: Card(
           child: SingleChildScrollView(
                child: Container( padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                            'Notification Bar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                      Text(
                            'Having a container fit the size of the context flutte,'),
                    ],
                  ),
                ),
              ),
        )),
        Container(
          width: 260.0, child: Card(
           child: SingleChildScrollView(
                child: Container( padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                            'Notification Bar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                      Text(
                            'Having a container fit the size of the context flutte,'),
                    ],
                  ),
                ),
              ),
        )),
      ],
    ),
  );
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
