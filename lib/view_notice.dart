import 'package:flutter/material.dart';

class ViewNotice extends StatefulWidget {
  @override
  _ViewNoticeState createState() => _ViewNoticeState();
}

class _ViewNoticeState extends State<ViewNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          children: <Widget>[
            Text(
              'View Notice',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 8),
            Text(
              'From Doctor',
              style: TextStyle(color: Colors.blueAccent),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Notice Title",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(" Hi"),
              Divider(),
              Text(
                "Date of Published",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(" Hi"),
              Divider(),
              Text(
                "Notice Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(" Hi"),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
