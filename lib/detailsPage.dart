import 'package:flutter/material.dart';
import 'homePage2.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
String garden = "";
class DetailsPage extends StatefulWidget {
  const DetailsPage({this.data});

  final QueryDocumentSnapshot<Object?>? data;


  @override
  _DetailsPageState createState() => _DetailsPageState();

}

class _DetailsPageState extends State<DetailsPage> {
  void _moveScreen() {
    setState(() {
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: "Homepage")),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(widget.data!.get('Name')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 250,
              width: 250,
              alignment: Alignment.topCenter,
              child: Image(
                  image: NetworkImage(widget.data!.get('thumbnail'))
              )
            ),
            Container(
                color: Colors.green,
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Align(
                alignment: Alignment(0, 0),
                child: Text('Name: ' + widget.data!.get('Name') +
                    '\nSeason: ' + widget.data!.get('Season') +
                    '\nWater: ' + widget.data!.get('Water') +
                    '\nSun: ' + widget.data!.get('Sun') +
                    '\n\nPlanting Guide: ' + widget.data!.get('Depth') +
                    '\n\nHarvest: ' + widget.data!.get('Harvest'),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    )
                ),
              )
            ),
            ElevatedButton(
              onPressed: () {
                String addGarden = widget.data!.get('Name').toString();
                garden = garden + addGarden + ", ";
                _updateGarden(garden);
                _moveScreen();
              },
              child: Text(
                  'Add to list'
              ),
            ),
          ],
        ),
      ),
    );
  }
  _updateGarden(String name) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      FirebaseFirestore.instance.collection('Users')
          .doc(firebaseUser.uid)
          .update({'garden': name});
    }
  }
}



