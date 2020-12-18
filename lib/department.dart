import 'package:flutter/material.dart';
// import 'package:http/http.dart'; as http;

class Depart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      home: Department(),
    );
  }
}

class Department extends StatefulWidget {
  @override
  _DepartmentState createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        // leading: Icon(Icons.arrow_back),
        backgroundColor: Colors.indigoAccent,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'You are Looking For.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              eyeButton(context),
              SizedBox(height: 10.0),
              foodButton(context),
              SizedBox(height: 10.0),
              cancerButton(context),
              SizedBox(height: 10.0),
              birthButton(context),
              SizedBox(height: 10.0),
              diabitiesButton(context),
              SizedBox(height: 10.0),
              dentistButton(context),
              SizedBox(height: 10.0),
              pulmonologyButton(context),
              SizedBox(height: 10.0),
              psychologistButton(context),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}

Widget eyeButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        '        Eye Vision          ',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {});
}

Widget foodButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        '      Food & Nutrition     ',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {});
}

Widget cancerButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        '         Cancer           ',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {});
}

Widget birthButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        '   Pregnancy & Reproduction   ',
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

Widget pulmonologyButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        '     Pulmonology     ',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {});
}

Widget psychologistButton(BuildContext context) {
  return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        '     Psychologist     ',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {});
}
