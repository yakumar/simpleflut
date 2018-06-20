
import 'package:firebase_database/firebase_database.dart';

class Player {
  String key;

  String name;
  String age;
  int dateTime = new DateTime.now().millisecondsSinceEpoch;


  Player(this.name, this.age);

  Player.toSnapshot(DataSnapshot snapshot){
    key = snapshot.key;
    name = snapshot.value['name'];
    age = snapshot.value['age'];
    dateTime = snapshot.value['dateTime'];

  }

  toJson(){

    return {
      "name": name,
      "age": age,
      "dateTime": dateTime,


    };
  }




}
