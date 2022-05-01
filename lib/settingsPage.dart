import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'settingsProfilePage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {
  void _moveScreen() {
    setState(() {
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => settingsProfilePage()),
    );
  }
  String uid = 'xxxx';
  String email = 'example@gmail.com';
  String location = 'City, State';
  String name = 'John Doe';
  String age = '30';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        actions: [
          FlatButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MySignInPage(title: "Sign in Page")));
              },
              icon: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              label: Text(
                'Log out',
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ))
        ],
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                child: Align(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text(
                            "Loading data...Please wait",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        return Text(
                          "Name: $name",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                child: Align(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text(
                            "Loading data...Please wait",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        return Text(
                          "Email: $email",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                child: Align(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text(
                            "Loading data...Please wait",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        return Text(
                          "Age: $age",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                child: Align(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text(
                            "Loading data...Please wait",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                        return Text(
                          "Location: $location",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 5),
                child: ElevatedButton(
                  onPressed: () {
                    _moveScreen();
                  },
                  child: Text(
                      'Edit Profile'
                  ),
                ),
              )
            ]
        )
      ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        uid = ds.data()!['uid'];
      }).catchError((e) {
        print(e);
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        email = ds.data()!['email'];
      }).catchError((e) {
        print(e);
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        age = ds.data()!['age'];
      }).catchError((e) {
        print(e);
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        name = ds.data()!['name'];
      }).catchError((e) {
        print(e);
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        location = ds.data()!['location'];
      }).catchError((e) {
        print(e);
      });
    }
  }
}
