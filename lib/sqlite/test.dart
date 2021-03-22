import "package:flutter/material.dart";
import 'db.dart';

class SqlTest extends StatefulWidget {
  SqlTest({Key key}) : super(key: key);

  @override
  _SqlTestState createState() => _SqlTestState();
}

class _SqlTestState extends State<SqlTest> {
  var db = new Note();

  insetData() async {
    var count = await db.create({"note": "basel"});
    print(count);
  }

  getData() async {
    var response = await db.getData();
    print(response);
    return response;
  }

  deleteTable() async {
    await db.deleteAllNote();
  }

  @override
  void initState() {
    getData();
    // deleteTable();
    // insetData() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Container(child: Text("wael")),
    );
  }
}
