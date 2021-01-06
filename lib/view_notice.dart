import 'package:Hello_Doctor/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewNotice extends StatefulWidget {
  final UserModel userModel;

  const ViewNotice({Key key, @required this.userModel}) : super(key: key);
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(widget.userModel.uid)
            .collection('notice')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data.documents.length <= 0) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text('No notice avaiable yet !'),
              ),
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data.documents.length,
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Notice Title",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text(" ${snapshot.data.documents[index]['title']}"),
                      Divider(),
                      Text(
                        "Date of Published",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text(" ${snapshot.data.documents[index]['date']}"),
                      Divider(),
                      Text(
                        "Notice Details",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text(" ${snapshot.data.documents[index]['description']}"),
                      Divider(),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
