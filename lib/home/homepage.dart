import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_flutter/crud/editnotes.dart';
import 'package:course_flutter/crud/viewnotes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    print(user.email);
  }

  var fbm = FirebaseMessaging.instance;


 initalMessage() async {
    
   var message =   await FirebaseMessaging.instance.getInitialMessage() ;

   if (message != null){
     
     Navigator.of(context).pushNamed("addnotes") ; 

   } 

 }


 requestPermssion() async {
    
    FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }

 }

 
  @override
  void initState() {
     requestPermssion() ; 
     initalMessage() ; 
    fbm.getToken().then((token) {
      print("=================== Token ==================");
      print(token);
      print("====================================");
    });


   
    
    FirebaseMessaging.onMessage.listen((event) {
      print("===================== data Notification ==============================") ; 
      
      //  AwesomeDialog(context: context , title: "title" , body: Text("${event.notification.body}"))..show() ; 
      
      Navigator.of(context).pushNamed("addnotes") ; 

    }) ; 
  

    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed("login");
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("addnotes");
          }),
      body: Container(
        child: FutureBuilder(
            future: notesref
                .where("userid",
                    isEqualTo: FirebaseAuth.instance.currentUser.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, i) {
                      return Dismissible(
                          onDismissed: (diretion) async {
                            await notesref
                                .doc(snapshot.data.docs[i].id)
                                .delete();
                            await FirebaseStorage.instance
                                .refFromURL(snapshot.data.docs[i]['imageurl'])
                                .delete()
                                .then((value) {
                              print("=================================");
                              print("Delete");
                            });
                          },
                          key: UniqueKey(),
                          child: ListNotes(
                            notes: snapshot.data.docs[i],
                            docid: snapshot.data.docs[i].id,
                          ));
                    });
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

class ListNotes extends StatelessWidget {
  final notes;
  final docid;
  ListNotes({this.notes, this.docid});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ViewNote(notes: notes);
        }));
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "${notes['imageurl']}",
                fit: BoxFit.fill,
                height: 80,
              ),
            ),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text("${notes['title']}"),
                subtitle: Text(
                  "${notes['note']}",
                  style: TextStyle(fontSize: 14),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return EditNotes(docid: docid, list: notes);
                    }));
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
