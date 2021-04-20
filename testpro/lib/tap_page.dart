

import 'package:flutter/material.dart';
class TapPage extends StatefulWidget {
TapPage({this.prod});
  final Map prod;

  @override
  _TapPageState createState() => _TapPageState();
}

class _TapPageState extends State<TapPage> {

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
           Text(this.widget.prod['name']),
            
          ],
        ),
      ),
    );
  }
}