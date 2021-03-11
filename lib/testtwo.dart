import 'package:flutter/material.dart';

class TestTwo extends StatefulWidget {
  TestTwo({Key key}) : super(key: key);
  @override
  _TestTwoState createState() => _TestTwoState();
}

class _TestTwoState extends State<TestTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test Two'),
        ),
        body: Column(
          children: [
            
          ],
        ));
  }
}
