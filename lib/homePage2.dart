import 'package:flutter/material.dart';
import 'settingsPage.dart';
import 'schedulePage.dart';
import 'searchPage.dart';

class home2Page extends StatefulWidget {
  const home2Page({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<home2Page> createState() => _home2PageState();
}

class _home2PageState extends State<home2Page> {
  @override
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
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 100),
              child: Image(
                  image: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/000/370/369/small/3678.jpg')
              ),
            ),
          ],
        ),
      ),
    );
  }
}
