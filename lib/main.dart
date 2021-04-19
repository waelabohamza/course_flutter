import 'package:course_flutter/auth/login.dart';
import 'package:course_flutter/auth/signup.dart';
import 'package:course_flutter/crud/addnotes.dart';
import 'package:course_flutter/home/homepage.dart';
import 'package:course_flutter/sqlite/addnote.dart';
 
import 'package:course_flutter/test.dart';
import 'package:course_flutter/testtwo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

bool islogin;

Future backgroudMessage(RemoteMessage message) async {
  print("=================== BackGroud Message ========================");
  print("${message.notification.body}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroudMessage);

  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: islogin == false ? Login() : HomePage(),
      home: Test(),
      theme: ThemeData(
          // fontFamily: "NotoSerif",
          primaryColor: Colors.blue,
          buttonColor: Colors.blue,
          textTheme: TextTheme(
            headline6: TextStyle(fontSize: 20, color: Colors.white),
            headline5: TextStyle(fontSize: 30, color: Colors.blue),
            bodyText2: TextStyle(fontSize: 20, color: Colors.black),
          )),
      routes: {
        "login": (context) => Login(),
        "signup": (context) => SignUp(),
        "homepage": (context) => HomePage(),
        "addnotes": (context) => AddNotes(),
        "testtwo": (context) => TestTwo()  ,
        "addnote" : (conetxt) => AddNotesSql() , 
      
      },
    );
  }
}
