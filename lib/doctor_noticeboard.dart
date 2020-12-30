import 'package:flutter/material.dart';

class DoctorNoticeBoard extends StatefulWidget {
  final String notice;

  const DoctorNoticeBoard({Key key, this.notice}) : super(key: key);
  @override
  _DoctorNoticeBoardState createState() => _DoctorNoticeBoardState();
}

class _DoctorNoticeBoardState extends State<DoctorNoticeBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Notice",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Board",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      body: Container(),
    );
  }
}
