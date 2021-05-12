import 'package:flutter/material.dart'; 
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
  return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: SingleChildScrollView(child:
         
          Container( 
            decoration: BoxDecoration(
             boxShadow:[ 
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
 padding: const EdgeInsets.only(left:10.0,right: 10.0, top: 10.0,bottom: 28.0),
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
                                              dataLabelSettings: DataLabelSettings(isVisible: true)
                                )
                              ]
                          ),
                        ),
            ),
                  ),
             buildGrid(),
             slideshow(),
            ],
          ),
          )
        )
  ); 
  }}

buildGrid() {
    return Container(
      padding: const EdgeInsets.only(left:10.0,right: 10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Container(
                       height: 100.0,
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
                 height: 100.0,
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
           ] ),
    );
}

slideshow(){
  return  Container(
           padding: const EdgeInsets.only(top: 10.0),
            height: 80.0,
            width: 500.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:[
                Container(
                   width: 160.0,
                child: Card(
                )
                ),
                Container(
                  width: 160.0,
                   child: Card(
                )
                ),
                Container(
                  width: 160.0,
                  child: Card(
                )
                ),
                Container(
                  width: 160.0,
                  child: Card(
                )
                ),
                Container(
                  width: 160.0,
                  child: Card(
                )
                ),
              ],
            ),
          );
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

