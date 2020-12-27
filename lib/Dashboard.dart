import 'package:Hello_Doctor/Widget/departmentbtn.dart';
import 'package:Hello_Doctor/inquary_desk.dart';
import 'package:Hello_Doctor/inside_department.dart';
import 'package:Hello_Doctor/other_department.dart';
import 'package:Hello_Doctor/newsView/news_home_page.dart';
import 'package:Hello_Doctor/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart'; as http;

class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: SizedBox(),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return SplashScreen();
                  }));
                });
              })
        ],
        backgroundColor: Colors.indigoAccent,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Dashboard',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.topLeft,
                      child: mydoctorButton(context)),
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(left: 120.0, top: 5.0),
                    child: inquaryDeskButton(context),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              height: 394.0,
              width: 300.0,
              margin: EdgeInsets.all(0.0),
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: Text(
                      'You are looking for..',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    child: Column(
                      children: <Widget>[
                        DepartmentButton(department: "General Physician"),
                        SizedBox(height: 10.0),
                        DepartmentButton(department: "Gynecologist"),
                        SizedBox(height: 10),
                        DepartmentButton(department: "Cardiologist"),
                        SizedBox(height: 10.0),
                        DepartmentButton(department: "Paediatricians"),
                        SizedBox(height: 10.0),
                        DepartmentButton(department: "Endocrinologists"),
                        SizedBox(height: 10.0),
                        otherButton(context),
                        // SizedBox(height: 10.0),
                        // otherButton(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: newsarticleButton(context)),
                  SizedBox(width: 40),
                  Container(
                    child: commentButton(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget mydoctorButton(BuildContext context) {
  return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.blueAccent[100],
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        'My Doctor',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {});
}

Widget inquaryDeskButton(BuildContext context) {
  return RaisedButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    color: Colors.blueAccent[100],
    elevation: 10.0,
    highlightElevation: 30.0,
    child: Text(
      'Inquary Desk',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InquaryDesk(),
        ),
      );
    },
  );
}

Widget otherButton(BuildContext context) {
  return RaisedButton(
    padding: EdgeInsets.all(13.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    color: Colors.black,
    elevation: 10.0,
    highlightElevation: 30.0,
    child: Text(
      '            Other             ',
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OtherDepartment()));
    },
  );
}

Widget newsarticleButton(BuildContext context) {
  return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.blueAccent[100],
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        'News Article',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewsHomePage()));
      });
}

Widget commentButton(BuildContext context) {
  return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.blueAccent[100],
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        'Comment Box',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {});
}
