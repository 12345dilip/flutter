

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
        body: SfCartesianChart(
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
        )
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}



//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Syncfusion Flutter chart'),
//         ),
//         body: Column(children: [
//           SfCartesianChart(
//               primaryXAxis: CategoryAxis(),
//               title: ChartTitle(text: 'Half yearly sales analysis'),
//               legend: Legend(isVisible: true)
//               tooltipBehavior: TooltipBehavior(enable: true),
//               series: <ChartSeries<_SalesData, String>>[
//                 LineSeries<_SalesData, String>(
//                     dataSource: data,
//                     xValueMapper: (_SalesData sales, _) => sales.year,
//                     yValueMapper: (_SalesData sales, _) => sales.sales,
//                     name: 'Sales',
//                     dataLabelSettings: DataLabelSettings(isVisible: true))
//               ]),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SfSparkLineChart.custom(
//                 trackball: SparkChartTrackball(
//                     activationMode: SparkChartActivationMode.tap),
//                 marker: SparkChartMarker(
//                     displayMode: SparkChartMarkerDisplayMode.all),
//                 labelDisplayMode: SparkChartLabelDisplayMode.all,
//                 xValueMapper: (int index) => data[index].year,
//                 yValueMapper: (int index) => data[index].sales,
//                 dataCount: 5,
//               ),
//             ),
//           )
//         ]));
//   }
// }

// class _SalesData {
//   _SalesData(this.year, this.sales);

//   final String year;
//   final double sales;
// }