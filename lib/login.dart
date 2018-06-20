import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'user.dart';
import 'home.dart';



final FirebaseAuth auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();

  User user;
  FirebaseUser firebaseUser;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Init state from LOGIN :: ');

    user = User("", "");
  }


//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//    print('Dispose from Login ::');
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        //alignment: Alignment.,
          margin: new EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 0.0),
          child: new Center(
        child: new Form(
            key: loginFormKey,
            child: new Flex(
              direction: Axis.vertical,
              //shrinkWrap: true,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.all(18.0),
                  child: new TextFormField(
                    decoration: new InputDecoration(labelText: 'type username'),
                    onSaved: (val) => user.userName = val,
                    validator: (val){
                      if(val.isEmpty){
                        return 'Type userName';
                      }
                    },
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.all(18.0),
                  child: new TextFormField(
                    decoration: new InputDecoration(labelText: 'type password'),
                    onSaved: (val) => user.password = val,
                    validator: (val){
                      if(val.isEmpty){
                        return 'Type password';
                      }
                    },
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.all(18.0),
                  child: new Row(
                    children: <Widget>[
                      new RaisedButton(
                        onPressed: ()=> _LoginUser(),
                        child: new Text('Log in'),

                      ),
                      new RaisedButton(
                        onPressed: ()=> _signUp(),
                        child: new Text('Sign UP'),

                      ),
                    ],
                  )
                ),



              ],
            )),
      )),
    );
  }

 Future<FirebaseUser> _LoginUser() async {

    final FormState loginForm = loginFormKey.currentState;

    if (loginForm.validate()){
      firebaseUser = await auth.signInWithEmailAndPassword(
          email: user.userName,
          password: user.password).then((val){
        print(val.email);
        loginForm.save();

        loginForm.reset();
        return val;

      }).catchError((err) {
        print(err);
        loginForm.reset();
        print(user.userName);

        //return user;


      });
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);


      return firebaseUser;

    }

 }

 Future<FirebaseUser> _signUp() async {
   final FormState signInForm = loginFormKey.currentState;

   if(signInForm.validate()){

     firebaseUser = await auth.createUserWithEmailAndPassword(
         email: user.userName,
         password: user.password
     ).then((user){
       print(user.email);
       signInForm.save();

       Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);


       signInForm.reset();

     }).catchError((error){
       print(error);
     });

   }


   //Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Home()),);
   //Navigator.of(context).pushNamedAndRemoveUntil(newRouteName, predicate)
   //Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => new Home()), (Route<dynamic> route) => true);




   return firebaseUser;
 }

}
