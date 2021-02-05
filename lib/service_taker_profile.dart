import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ServiceTakerProfile extends StatefulWidget {
  @override
  _ServiceTakerProfileState createState() => _ServiceTakerProfileState();
}

class _ServiceTakerProfileState extends State<ServiceTakerProfile> {
  String uid;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen(
      (User user) async {
        if (user != null) {
          setState(() {
            uid = user.uid;
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 08,
            ),
            Text(
              "Profile",
              style: TextStyle(color: Colors.blue[700]),
            )
          ],
        ),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('user').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  CircleAvatar(
                    maxRadius: 60,
                    minRadius: 60,
                    backgroundImage:
                        CachedNetworkImageProvider(snapshot.data['photoUrl']),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full Name",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${snapshot.data['fullName']}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Divider(),
                        Text(
                          "Contact",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${snapshot.data['contact']} ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Divider(),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${snapshot.data['email']} ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
