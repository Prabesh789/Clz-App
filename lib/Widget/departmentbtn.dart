import 'package:Hello_Doctor/inside_department.dart';
import 'package:flutter/material.dart';

class DepartmentButton extends StatelessWidget {
  final String department;

  const DepartmentButton({@required this.department});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.black,
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        "${this.department}",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InsideDepartment(
              department: "${this.department}",
            ),
          ),
        );
      },
    );
  }
}
