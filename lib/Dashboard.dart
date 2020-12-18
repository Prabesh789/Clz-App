import 'package:Hello_Doctor/department.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart'; as http;

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      home: MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  // String newsResponse;
  // List listResponse;

  // Future fetchData() async {
  //   http.Response response;
  //   response = await http.get(https://www.medicalnewstoday.com/);
  //   if(response.statusCode == 200){
  //     setState(() {
  //       listResponse = response.body;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
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
                    padding: EdgeInsets.only(left: 150.0, top: 5.0),
                    child: inquaryDeskButton(context),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              height: 450.0,
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
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          genrealButton(context),
                          SizedBox(height: 10.0),
                          gynecologyButton(context),
                          SizedBox(height: 10),
                          cardiologyButton(context),
                          SizedBox(height: 10.0),
                          pediatricsButton(context),
                          SizedBox(height: 10.0),
                          diabitiesButton(context),
                          SizedBox(height: 10.0),
                          dentistButton(context),
                          SizedBox(height: 10.0),
                          otherButton(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(right: 230.0),
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: newsarticleButton(context)),
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
      onPressed: () {});
}

Widget genrealButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        'General Physicans',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {});
}

Widget gynecologyButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        '      Gynecology     ',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {});
}

Widget cardiologyButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        '      Cardiology       ',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {});
}

Widget pediatricsButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        '      Pediatrisc        ',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {});
}

Widget diabitiesButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        '        Diabities         ',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {});
}

Widget dentistButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        '         Dental          ',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {});
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
            context, MaterialPageRoute(builder: (context) => Depart()));
      });
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
      onPressed: () {});
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
