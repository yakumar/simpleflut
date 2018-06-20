import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';

import 'player.dart';
import 'addPlayer.dart';

import 'home.dart';
import 'login.dart';
import 'soloPlayer.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Login(),
      //initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/home': (BuildContext context)=> new Home(),
        '/addPlayer': (BuildContext context) => new AddPlayer(),
        //'/soloPlayer': (BuildContext context) => new SoloPlayer(fireKey: "",),



      },
    );
  }
}

