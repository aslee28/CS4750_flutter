import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_project_garden/homepage.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class settingsProfilePage extends StatefulWidget {
  @override
  _settingsProfileState createState() => _settingsProfileState();
}


class _settingsProfileState extends State<settingsProfilePage> {
  void _moveScreen() {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: "HomePage")),
    );
  }
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  String uid = 'xxxx';
  String email = 'example@gmail.com';
  String location = 'City, State';
  String name = 'John Doe';
  String age = "30";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Settings"),
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
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text("Loading data...Please wait");
                    return TextField(
                      controller: nameController,
                      obscureText: false,
                      onSubmitted: (String value) {
                        _updateName(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '$name',
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text("Loading data...Please wait");
                    return TextField(
                      controller: emailController,
                      obscureText: false,
                      onSubmitted: (String value) {
                        _updateEmail(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '$email',
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      "Age",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text("Loading data...Please wait");
                    return TextField(
                      controller: ageController,
                      obscureText: false,
                      onSubmitted: (String value) {
                        _updateAge(value.toString());
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '$age',
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text("Loading data...Please wait");
                    return TextField(
                      controller: locationController,
                      obscureText: false,
                      onSubmitted: (String value) {
                        _updateLocation(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '$location',
                      ),
                    );
                  },
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      _moveScreen();
                    },
                    child: Text(
                        'Save Profile'
                    ),
                  ),
                )
              ]
          )
      ),
    );
  }

  _updateName(String name) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      FirebaseFirestore.instance.collection('Users')
          .doc(firebaseUser.uid)
          .update({'name': name});
    }
  }
  _updateEmail(String email) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      FirebaseFirestore.instance.collection('Users')
          .doc(firebaseUser.uid)
          .update({'email': email});
    }
  }
  _updateAge(String age) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      FirebaseFirestore.instance.collection('Users')
          .doc(firebaseUser.uid)
          .update({'age': age});
    }
  }
  _updateLocation(String location) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      FirebaseFirestore.instance.collection('Users')
          .doc(firebaseUser.uid)
          .update({'location': location});
    }
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
