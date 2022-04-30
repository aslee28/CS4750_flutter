import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase.dart';
import 'users.dart';


final FirebaseAuth auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: MySignInPage(title: "Sign in")
    );
  }
}

class MySignInPage extends StatefulWidget {
  const MySignInPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MySignInPage> createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void _moveScreen() {
    setState(() {
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: 'GardenCare Home Page')),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text('GardenCare',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.green
                  )
              ),
            ),
            Image(
              image: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/000/370/369/small/3678.jpg')
            ),
            TextField(
              controller: usernameController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: usernameController.text,
                    password: passwordController.text)
                .then((value) {
                  print("Successful login");
                  _moveScreen();
                }).catchError((error) {
                  print("Failed to login");
                  print(error.toString());
                });
              },
              child: Text(
                'Login'
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.createUserWithEmailAndPassword(email: usernameController.text, password: passwordController.text)
                    .then((value) {
                      print("Successful sign up");
                      UserManagement().storeNewUser(value.user, context);
                      /*userSetup(usernameController.text, "John Doe", 30 , "City, State");*/
                }).catchError((error) {
                  print("Failed to sign up");
                  print(error.toString());
                });
              },
              child: Text(
                  'Sign up now'
              ),
            ),
          ],
        ),
      ),
    );
  }
}

