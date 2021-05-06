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
      
      appBar: AppBar(
        leading: Container(),
        title: Text('HomePage'),
        actions: <Widget>[
          new Container(),
        ],
      ),
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
                builder: (context) => Container(
                      child: Container(
                        color: Colors.white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: Column(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.home),
                                        onPressed: () {}),
                                    Text('Home'),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: Column(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.album_outlined),
                                        onPressed: () {

                                          Navigator.pushNamed(context, INVOICE_PAGE,
                                          arguments: {
                                                'values': this.widget.payload                                           
                                          });
                                          // Navigator.push(
                                          //     context,
                                          //     new MaterialPageRoute(
                                          //         builder: (context) => Invoice(
                                          //               values:
                                          //                   this.widget.payload,
                                          //             )));
                                        }),
                                    Text('Invoice'),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: Column(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.message),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            MESSAGE_PAGE,
                                            
                                            arguments: {
                                                'val': this.widget.payload,
                                                'company': data['data'][0]
                                                    ['createdBy']},
                                          
                                          
                                          );
                                          // Navigator.push(
                                          //     context,
                                          //     new MaterialPageRoute(
                                          //         builder: (
                                          //       context,
                                          //     ) =>
                                          //             Message(
                                          //                 val: this
                                          //                     .widget
                                          //                     .payload,
                                          //                 company: data['data']
                                          //                         [0]
                                          //                     ['createdBy'])));
                                        }),
                                    Text('Message'),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: Column(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.settings),
                                        onPressed: () => Scaffold.of(context)
                                            .openEndDrawer()),
                                    Text('Settings'),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    )),
          ],
        ),
      ]),
    );
  }
}

homepage() {
  return SingleChildScrollView(
      child: Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 20,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 28.0),
            height: 400.0,
            child: Card(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Half yearly sales analysis'),
                  legend: Legend(isVisible: true),
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
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        height: 90.0,
        width: 160.0,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Text1',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      Container(
        height: 90.0,
        width: 160.0,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Text 2',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ]),
  );
}

slideshow() {
  return Container(
    padding: const EdgeInsets.only(top: 10.0, bottom: 30),
    height: 80.0,
    width: 500.0,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(width: 160.0, child: Card()),
        Container(width: 160.0, child: Card()),
        Container(width: 160.0, child: Card()),
        Container(width: 160.0, child: Card()),
        Container(width: 160.0, child: Card()),
      ],
    ),
  );
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
