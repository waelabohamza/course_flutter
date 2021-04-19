import 'package:course_flutter/sqlite/db.dart';
import 'package:flutter/material.dart';

class AddNotesSql extends StatefulWidget {
  AddNotesSql({Key key}) : super(key: key);

  @override
  _AddNotesSqlState createState() => _AddNotesSqlState();
}

class _AddNotesSqlState extends State<AddNotesSql> {
  String note;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  var database = new SqlTest();

 

  addNotes() async {
    var formdata = formstate.currentState;

    if (formdata.validate()) {
      formdata.save();

     

      Navigator.of(context).pushNamed("testdb");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
          child: Column(
        children: [
          Form(
              key: formstate,
              child: Column(children: [
                TextFormField(
                  validator: (val) {
                    if (val.length > 255) {
                      return "Notes can't to be larger than 255 letter";
                    }
                    if (val.length < 10) {
                      return "Notes can't to be less than 10 letter";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    note = val;
                  },
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Note",
                      prefixIcon: Icon(Icons.note)),
                ),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    await addNotes();
                  },
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Text(
                    "Add Note",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              ]))
        ],
      )),
    );
  }
}
