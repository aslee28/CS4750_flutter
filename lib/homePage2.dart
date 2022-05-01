import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'detailsPage.dart';
import 'main.dart';
import 'homepage.dart';

class home2Page extends StatefulWidget {
  const home2Page({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<home2Page> createState() => _home2PageState();
}

class _home2PageState extends State<home2Page> {
  void _moveScreen() {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: "HomePage")),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Homepage"),
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
          children: [
            Container(
              margin: EdgeInsets.only(top: 100, bottom: 25),
              child: Image(
                  image: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/000/370/369/small/3678.jpg')
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Current Garden:",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 100),
                width: 250,
                height: 60,
                child: FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text(
                        "Loading data...Please wait",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      );
                    return Text(
                      garden,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    );
                  },
                ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  _updateGarden();
                  _moveScreen();
                },
                child: Text(
                    'Clear Garden'
                ),
              ),
            )
          ],
        ),
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
        garden = ds.data()!['garden'];
      }).catchError((e) {
        print(e);
      });
    };
  }

  _updateGarden() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      FirebaseFirestore.instance.collection('Users')
          .doc(firebaseUser.uid)
          .update({'garden': ""});
    }
  }
}
