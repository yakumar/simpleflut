import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'player.dart';
import 'soloPlayer.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
final FirebaseAuth auth = FirebaseAuth.instance;



class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  Player player;
  List<Player> playerList = new List<Player>();


  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
 // GlobalKey<> fireKey = new GlobalKey<String>();
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

    databaseReference.onChildChanged.listen(_onEntryChanged);
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('New APP BAR!!'),
          backgroundColor: Colors.blueAccent,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.add),
                onPressed: _onAddBtn)
          ],
        ),
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            new Expanded(
              child: new FirebaseAnimatedList(
                  shrinkWrap: true,
                  query: databaseReference.orderByChild('age'),
                  itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation, int index){
                    return new Card(
                      child: new ListTile(
                        //debugPrint(playerList[index].key
                        onTap: ()=>_onEdit(playerList[index].key),
                        trailing: new Text(playerList[index].age),
                        title: new Text(playerList[index].name),
                        leading: new CircleAvatar(backgroundColor: int.parse(playerList[index].age) > 40? Colors.redAccent.shade400: Colors.greenAccent,),
                      ),

                    );
                  }
              ),
            ),

          ],
        ));
  }


  void _onEntryAdded(Event event) {
    setState(() {

      playerList.add(Player.toSnapshot(event.snapshot));
    });
  }

  void _onEntryChanged(Event event) {

    var oldEntry = playerList.singleWhere((entry){
      return entry.key == event.snapshot.key;
    });
    setState(() {
      playerList[playerList.indexOf(oldEntry)] = Player.toSnapshot(event.snapshot);
    });


  }

  void _onAddBtn() {
    setState(() {
      Navigator.of(context).pushNamed('/addPlayer');
    });
  }

   _onEdit(String fKey) {

    setState(() {
      //Navigator.of(context).pushNamed('/soloPlayer');
      //        new SoloPlayer(fireKey: fKey,);

      print('fKey: : ${fKey}');

      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
        return new SoloPlayer(fireKey: fKey,);
      }));
    });
  }
}
