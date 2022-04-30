import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_project_garden/homepage.dart';

class UserManagement {
  storeNewUser(user, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser!.uid)
        .set({'email': user.email, 'uid': user.uid, 'name': 'John Doe', 'location': 'City, State', 'age': 30})
        .then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home'))))
        .catchError((e) {
      print(e);
    });
  }
}