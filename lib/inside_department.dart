import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InsideDepartment extends StatefulWidget {
  final String department;

  InsideDepartment({@required this.department});

  @override
  _InsideDepartmentState createState() => _InsideDepartmentState();
}

class _InsideDepartmentState extends State<InsideDepartment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Health",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "Department",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .where('department', isEqualTo: widget.department)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshots.data.documents.length <= 0) {
            return Center(
              child: Text('No doctors avaiable for ${widget.department}'),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: snapshots.data.documents.length,
              itemBuilder: (context, index) {
                return Text('${snapshots.data.documents[index]['fullName']}');
              },
            );
          }
        },
      ),
    );
  }
}
