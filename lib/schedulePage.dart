import 'package:flutter/material.dart';

class schedulePage extends StatefulWidget {
  const schedulePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<schedulePage> createState() => _schedulePageState();
}

class _schedulePageState extends State<schedulePage> {
  void _moveScreen() {
    setState(() {
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => schedulePage(title: 'GardenCare Schedule Page')),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                  'GardenCare',
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
          ],
        ),
      ),
    );
  }
}

