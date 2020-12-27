import 'package:Hello_Doctor/Widget/departmentbtn.dart';
import 'package:Hello_Doctor/inside_department.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart'; as http;

class OtherDepartment extends StatefulWidget {
  @override
  _OtherDepartmentState createState() => _OtherDepartmentState();
}

class _OtherDepartmentState extends State<OtherDepartment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
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
              DepartmentButton(department: "Ophthalmologist"),
              SizedBox(height: 10.0),
              DepartmentButton(department: "Nutritionists"),
              SizedBox(height: 10.0),
              DepartmentButton(department: "Medical Oncologist"),
              SizedBox(height: 10.0),
              DepartmentButton(department: "Reproductive endocrinologists"),
              SizedBox(height: 10.0),
              DepartmentButton(department: "Psychologist"),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
