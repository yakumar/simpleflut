import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class SoloPlayer extends StatefulWidget {
  String fireKey;

  SoloPlayer({this.fireKey});

  @override
  _SoloPlayerState createState() => new _SoloPlayerState(fireKey: fireKey);
}

class _SoloPlayerState extends State<SoloPlayer> {
  String fireKey;
  TextEditingController _nameController = new TextEditingController();

  _SoloPlayerState({this.fireKey});

  DatabaseReference databaseReference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('SoloPlayer initialized');
    databaseReference =
        database.reference().child('footbal_player').child(fireKey);
    //databaseReference.onChildAdded.listen(_onEntryAdded);

    print('${fireKey}');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('$fireKey'),
        backgroundColor: Colors.greenAccent.shade400,
      ),
      body: new Container(
          alignment: Alignment.center,
          child: new Center(
              child: new FutureBuilder(
                  future: databaseReference.once(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DataSnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return new Container();
                    }
                    Map content = snapshot.data.value;

                    // return new Text('${content['name']}');

                    return new ListView(
                      padding: new EdgeInsets.fromLTRB(50.0, 90.0, 40.0, 0.0),
                      children: <Widget>[
                        new Text(
                          '${content['name']}',
                          style: new TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20.0),
                        ),
                        new Text(
                          '${content['age']}',
                          style: new TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20.0),
                        ),
                        new Text(
                          '${content['dateTime']}',
                          style: new TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20.0),
                        ),
                        new TextField(
                          controller: _nameController,
                        ),
                      ],
                    );
                  }))),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.blue,
        child: new Icon(Icons.edit),
        onPressed: _editData,
      ),
    );
  }

  void _editData() async {
    Map<String, dynamic> newM = new Map();

    if(_nameController.text != ""){


      newM["name"] = _nameController.text;

      await databaseReference.update(newM);
      setState(() {
        _nameController.text = '';

      });



    }


    setState(() {});
  }
}
