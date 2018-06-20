import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'player.dart';



final FirebaseDatabase database = FirebaseDatabase.instance;
final FirebaseAuth auth = FirebaseAuth.instance;


class AddPlayer extends StatefulWidget {
  @override
  _AddPlayerState createState() => new _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  Player player;
  List<Player> playerList = new List<Player>();


  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  DatabaseReference databaseReference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Init state from HOME :: ');


    auth.currentUser().then((user){
      print(user.email);
    });

    player = Player("", "");
    databaseReference = database.reference().child('footbal_player');


    databaseReference.onChildAdded.listen(_onEntryAdded);

  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text('Add new Player'),
        backgroundColor: Colors.redAccent,
      ),
      body: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.all(18.0),
                child: new TextFormField(
                  decoration: new InputDecoration(labelText: 'Type Name'),
                  onSaved: (val) => player.name = val,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.all(18.0),
                child: new TextFormField(
                  decoration: new InputDecoration(labelText: 'Type Age'),
                  onSaved: (val) => player.age = val,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.all(18.0),
                child: new RaisedButton(
                  onPressed: _onSubmit,
                  child: new Text('Save'),
                ),
              ),
            ],
          ),
        ),


      ],
    ),
    );
  }



  void _onSubmit() {
    final FormState form = formKey.currentState;

    if(form.validate()){
      form.save();

      databaseReference.push().set(player.toJson());
      Navigator.of(context).pop();

      form.reset();
    }

  }

  void _onEntryAdded(Event event) {
    setState(() {

      playerList.add(Player.toSnapshot(event.snapshot));
    });
  }
}
