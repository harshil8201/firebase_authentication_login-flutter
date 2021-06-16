import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String email,pass;
  final fb = FirebaseDatabase.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final ref = fb.reference().child("Student");
    return Scaffold(
      appBar: AppBar(
        title: Text('Industry OS MIS'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: Text(
                    'Dashboard',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            TextFormField(
                onChanged: (val){
                  pass=val;
                },
                obscureText: true,
                decoration: new InputDecoration(
                    hintText: 'Title',
                    labelText: 'Enter your password',
                    labelStyle: TextStyle(
                      color: Colors.purple,
                    ),
                    icon: new Icon(Icons.lock)
                ),
            ),
            SizedBox(height: 40,),
            TextFormField(
              onChanged: (val){
                email=val;
              },
              obscureText: true,
              decoration: new InputDecoration(
                  hintText: 'Description',
                  labelText: 'Enter your password',
                  labelStyle: TextStyle(
                    color: Colors.purple,
                  ),
                  icon: new Icon(Icons.lock)
              ),
            ),
            SizedBox(height: 40,),
            Container(
              height:50.0,
              width: 210.0,
              margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40.0),
              child: RaisedButton(
                onPressed: () async {
                  UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: pass);
                  if(result!=null){
                    ref.child(User).set({
                      "password": pass,
                      "email":email,
                    }
                    );
                  }
                },
                child: new Text(
                  'Register',
                  style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                color: Colors.purple,
              ),
            ),

            Material(
              color: Colors.grey[300],
              child: MaterialButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text('sign out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
