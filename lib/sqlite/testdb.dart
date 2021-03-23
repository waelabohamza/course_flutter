import 'package:course_flutter/sqlite/db.dart';
import 'package:flutter/material.dart';

class TestDB extends StatefulWidget {
  TestDB({Key key}) : super(key: key);

  @override
  _TestDBState createState() => _TestDBState();
}

class _TestDBState extends State<TestDB> {
  var database = new SqlTest();

  List notes = [];

  getData() async {
    var res = await database.readData("select * from notes");
    setState(() {
      notes.addAll(res);
    });
    print(res);
  }

  updateData() async {
    var response = await database
        .insertData("UPDATE notes SET note = 'yaser' WHERE id = 4 ");

    print(response);
  }

  deleteData(int id) async {
    var response =
        await database.deleteData("DELETE FROM notes WHERE id = $id ");

    print(response);
  }

  @override
  void initState() {
    getData();
    // deleteData() ;

    // updateData() ;
    // insertData()  ;

    // deleteData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Db'),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("addnote");
          }),
      body: notes.isEmpty || notes == null
          ? Text("Loading ...")
          : Container(
              child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ListTile(
                          title: Text("${notes[index]['note']}"),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_forever_outlined),
                            onPressed: () async {
                              await deleteData(int.parse(notes[index]['id'].toString()));
                              Navigator.of(context).pushNamed("testdb");
                            },
                          ),
                        ),
                      ),
                    );
                  })),
    );
  }
}

// SQFlite 
