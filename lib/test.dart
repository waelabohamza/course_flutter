import 'dart:ui';

import 'package:course_flutter/sqlite/db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  SqlTest dbSql = new SqlTest();
  @override
  void initState() {
    dbSql.myDeleteDatabase() ; 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Column(
          children: [
            Center(
                child: TextButton(
              onPressed: () async {
                var res = await dbSql.readData("notes") ;
                print(res) ;  
              },
              child: Text("Click"),
              style: TextButton.styleFrom(
                  primary: Colors.white, backgroundColor: Colors.red),
            ) , 
            ) , 
                Center(
                child: TextButton(
              onPressed: () async {
               var res =  await  dbSql.insertData("books", <String , Object>{
                  "book" : "wael"
                }); 
                print("=========================") ;
                print(res) ;
              },
              child: Text("Insert Data"),
              style: TextButton.styleFrom(
                  primary: Colors.white, backgroundColor: Colors.red),
            ) , 
            )
          ],
        ));
  }
}
