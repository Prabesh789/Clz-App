import 'package:Hello_Doctor/model/userModel.dart';
import 'package:flutter/material.dart';

class ServiceTakerProfile extends StatefulWidget {
  final UserModel userModel;

  const ServiceTakerProfile({Key key, this.userModel}) : super(key: key);
  @override
  _ServiceTakerProfileState createState() => _ServiceTakerProfileState();
}

class _ServiceTakerProfileState extends State<ServiceTakerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My",
              style: TextStyle(color: Colors.blue[900]),
            ),
            SizedBox(
              width: 08,
            ),
            Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
