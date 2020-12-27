import 'package:flutter/material.dart';

class InquaryDesk extends StatefulWidget {
  @override
  _InquaryDeskState createState() => _InquaryDeskState();
}

class _InquaryDeskState extends State<InquaryDesk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Inquary",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              " Desk",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            question1(context),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

Widget question1(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(15.0),
    child: Column(
      children: <Widget>[
        Text(
          "1. What is 'Hello Doctor' is about?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          "- This is a digital platform to provide and take health services. Here, Doctor's are the service provider and public are service taker.",
          style: TextStyle(fontSize: 18, color: Colors.blue),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
