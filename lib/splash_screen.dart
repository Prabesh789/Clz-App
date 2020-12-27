import 'package:Hello_Doctor/Dashboard.dart';
import 'package:Hello_Doctor/Landingpage.dart';
import 'package:Hello_Doctor/doctor_dashboard.dart';
import 'package:Hello_Doctor/model/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserModel userModel;
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (user == null) {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (BuildContext context) {
          return Landingpage();
        }));
      } else {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get()
            .then((ds) {
          setState(() {
            userModel = UserModel(
                userType: ds['userType'],
                bio: ds['bio'],
                contact: ds['contact'],
                department: ds['department'],
                email: ds['email'],
                fullName: ds['fullName'],
                password: ds['password']);
          });
        });
        if (userModel.userType == "Doctor") {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (BuildContext context) {
            return DoctorDashboard();
          }));
        } else {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (BuildContext context) {
            return MyDashboard();
          }));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 30,
            ),
            Text("Please Wait..."),
          ],
        ),
      ),
    );
  }
}
