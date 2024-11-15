// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/firebase_options.dart';
import 'package:to_do_application/my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
//await FirebaseFirestore.instance.disableNetwork();
  runApp(const MyApp());
}
/*
DropdownButton<String>(
  items: <String>['A', 'B', 'C', 'D'].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
  onChanged: (_) {},
)
*/