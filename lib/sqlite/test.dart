import "package:flutter/material.dart" ;
import 'package:sqflite/sqflite.dart'; 

 

class SqlTest extends StatefulWidget {
  SqlTest({Key key}) : super(key: key);

  @override
  _SqlTestState createState() => _SqlTestState();
}

class _SqlTestState extends State<SqlTest> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("wael"),
    );
  }
}